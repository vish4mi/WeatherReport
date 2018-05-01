//
//  WeatherDetailsViewController.swift
//  WeatherReport
//
//  Created by Vishal on 29/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import UIKit
import CoreStore

class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet weak var weatherDetailsCollectionView: UICollectionView!
    var weatherReportModels: [WeatherReportModel]?
    fileprivate let weatherDetailViewCellIdentifier = "WeatherDetailsViewCell"
    var selectedIndexPath: IndexPath?
    var initialScrollDone: Bool = false

    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register for DB change monitoring
        DBHandler.sharedHandler.setListMonitor(with: self)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let visibleIndexPaths = weatherDetailsCollectionView.indexPathsForVisibleItems
        if visibleIndexPaths.count > 0 {
            let visibleIndexPath  = visibleIndexPaths[0]
            selectedIndexPath = visibleIndexPath
            pageControl.currentPage = visibleIndexPath.row
            if let weatherModels = weatherReportModels, visibleIndexPath.row < weatherModels.count {
                let weatherModel = weatherModels[visibleIndexPath.row]
                let weatherDetailsViewModel = WeatherDetailsViewModel(with: weatherModel)
                navigationItem.title = weatherDetailsViewModel.cityName.value
            }
        }
        
        if !initialScrollDone {
            initialScrollDone = true
            if let indexPath = selectedIndexPath {
                weatherDetailsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }
        }
    }
}

extension WeatherDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let weatherReportModels = self.weatherReportModels {
            return weatherReportModels.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aCell: WeatherDetailsViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: weatherDetailViewCellIdentifier, for: indexPath) as! WeatherDetailsViewCell
        aCell.configure()
        if let weatherReportModels = self.weatherReportModels, indexPath.row < weatherReportModels.count {
            let weatherReportModel = weatherReportModels[indexPath.row]
            let weatherDetailsViewModel = WeatherDetailsViewModel(with: weatherReportModel)
            aCell.setupCell(with: weatherDetailsViewModel)
            aCell.layoutIfNeeded()
        }
        return aCell
    }
    
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension WeatherDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = weatherDetailsCollectionView.frame.width
        let collectionViewHeight = weatherDetailsCollectionView.frame.height
        return CGSize(width: collectionViewWidth-10, height: collectionViewHeight-10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var insets = UIEdgeInsets.zero
        insets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension WeatherDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        if visibleIndexPaths.count > 0 {
            let visibleIndexPath  = visibleIndexPaths[0]
            selectedIndexPath = visibleIndexPath
            pageControl.currentPage = visibleIndexPath.row
            if let weatherModels = weatherReportModels, visibleIndexPath.row < weatherModels.count {
                let weatherModel = weatherModels[visibleIndexPath.row]
                let weatherDetailsViewModel = WeatherDetailsViewModel(with: weatherModel)
                navigationItem.title = weatherDetailsViewModel.cityName.value
            }
        }
    }
}

extension WeatherDetailsViewController: ListObserver {
    func listMonitorDidChange(_ monitor: ListMonitor<WeatherInfo>) {
        print(monitor.objectsInAllSections())
        
    }
    
    func listMonitorDidRefetch(_ monitor: ListMonitor<WeatherInfo>) {
    }
}
