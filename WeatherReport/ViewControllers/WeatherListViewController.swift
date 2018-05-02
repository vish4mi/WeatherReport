//
//  WeatherListViewController.swift
//  WeatherReport
//
//  Created by Vishal on 29/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import UIKit
import CoreStore

class WeatherListViewController: UIViewController {

    fileprivate let weatherCellIdentifier = "WeatherListTableViewCell"
    fileprivate var weatherListViewModels: [WeatherListViewModel]?
    fileprivate var weatherReportModels: [WeatherReportModel]?
    var selectedIndexPath: IndexPath?
    @IBOutlet weak var weatherListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.showActivityIndicator()
        DBHandler.sharedHandler.requestWeatherReport()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Register for DB change monitoring
        DBHandler.sharedHandler.setListMonitor(with: self)
        // Fetch weather data
        DBHandler.sharedHandler.fetchWeatherData { (weatherReports, error) in
            guard let weatherViewModels = weatherReports else { return }
            self.weatherReportModels = weatherViewModels
            self.weatherListViewModels = [WeatherListViewModel]()
            for weatherReportModel in weatherViewModels {
                let weatherListViewModel = WeatherListViewModel(with: weatherReportModel)
                self.weatherListViewModels?.append(weatherListViewModel)
            }
            self.view.hideActivityIndicator()
            self.weatherListTableView.reloadData()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        DBHandler.sharedHandler.unSetListMonitor(with: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SHOW_WEATHER_DETAILS_VC_SEGUE {
            if let weatherDetailsVC: WeatherDetailsViewController = segue.destination as? WeatherDetailsViewController {
                weatherDetailsVC.weatherReportModels = weatherReportModels
                weatherDetailsVC.selectedIndexPath = selectedIndexPath
            }
        }
    }
    
    func configureWeatherListView() {
        weatherListTableView.rowHeight = UITableViewAutomaticDimension
        weatherListTableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
}

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let weatherModels = weatherListViewModels {
            return weatherModels.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherTableViewCell: WeatherListTableViewCell = tableView.dequeueReusableCell(withIdentifier: weatherCellIdentifier, for: indexPath) as! WeatherListTableViewCell
        if let weatherModels = weatherListViewModels, indexPath.row < weatherModels.count {
            let weatherListViewModel = weatherModels[indexPath.row]
            weatherTableViewCell.setupCell(withViewModel: weatherListViewModel)
        }
        return weatherTableViewCell
    }
}

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let weatherModels = weatherListViewModels, indexPath.row < weatherModels.count {
            selectedIndexPath = indexPath
            self.performSegue(withIdentifier: Constants.SHOW_WEATHER_DETAILS_VC_SEGUE, sender: self)
        }
    }
}

extension WeatherListViewController: ListObjectObserver {
    
    func listMonitorDidRefetch(_ monitor: ListMonitor<WeatherInfo>) {
    }
    
    func listMonitorDidChange(_ monitor: ListMonitor<WeatherInfo>) {
        print(monitor.objectsInAllSections())
        let weatherEntries = monitor.objectsInAllSections()
        DBHandler.sharedHandler.getWeatherData(with: weatherEntries) { (weatherReports, error) in
            guard let weatherViewModels = weatherReports else { return }
            self.weatherReportModels = weatherViewModels
            self.weatherListViewModels = [WeatherListViewModel]()
            for weatherReportModel in weatherViewModels {
                let weatherListViewModel = WeatherListViewModel(with: weatherReportModel)
                self.weatherListViewModels?.append(weatherListViewModel)
            }
            self.view.hideActivityIndicator()
            self.weatherListTableView.reloadData()
        }
    }
    
    func listMonitor(_ monitor: ListMonitor<WeatherInfo>, didUpdateObject object: WeatherInfo, atIndexPath indexPath: IndexPath) {
        DBHandler.sharedHandler.getWeatherData(with: [object]) { (weatherReports, error) in
            guard let weatherViewModels = weatherReports else { return }
            for weatherReportModel in weatherViewModels {
                let weatherListViewModel = WeatherListViewModel(with: weatherReportModel)
                if var listViewModels = self.weatherListViewModels, indexPath.row < listViewModels.count {
                    listViewModels[indexPath.row] = weatherListViewModel
                }
                
                self.view.hideActivityIndicator()
                self.weatherListTableView.performBatchUpdates({
                    self.weatherListTableView.reloadRows(at: [indexPath], with: .automatic)
                }, completion: nil)
            }
        }
    }
    
    func listMonitor(_ monitor: ListMonitor<WeatherInfo>, didInsertObject object: WeatherInfo, toIndexPath indexPath: IndexPath) {
        
    }
}
