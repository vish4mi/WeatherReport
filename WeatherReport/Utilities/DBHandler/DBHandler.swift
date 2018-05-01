//
//  DBHandler.swift
//  WeatherReport
//
//  Created by Vishal on 29/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import CoreStore

class DBHandler: NSObject {
    // Weather data monitor
    var weatherMonitor: ListMonitor<WeatherInfo>?
    
    let cityList = [Constants.CITY_ID_SYDNEY, Constants.CITY_ID_MELBOURNE, Constants.CITY_ID_BRISBANE]
    
    // MARK:  Set up shared instance
    // Set up shared instance
    static let sharedHandler: DBHandler = {
        let instance = DBHandler()
        // setup code
        return instance
    }()
    
    // Set up List Monitor For Widget Entry
    func setListMonitor(with controller: AnyObject) {
        
        // Set up WidgetEntry Entity Monitor
        if weatherMonitor == nil {
            self.weatherMonitor = CoreStore.monitorList(
                From<WeatherInfo>()
                .orderBy(.ascending(\.id))
                    .tweak({ $0.includesPendingChanges = false }
                )
            )
        }
        //Add Observers
        switch controller {
        case is WeatherListViewController:
            let aVC: WeatherListViewController = (controller as? WeatherListViewController)!
            self.weatherMonitor?.addObserver(aVC)

        case is WeatherDetailsViewController:
            let aVC: WeatherDetailsViewController = (controller as? WeatherDetailsViewController)!
            self.weatherMonitor?.addObserver(aVC)
        default: break
        }
        
        
    }

    func fetchWeatherReport(with completion: @escaping([WeatherReportModel]?, Error?) -> Void) {
        var weatherReports: [WeatherReportModel] = [WeatherReportModel]()
        let group = DispatchGroup.init()
        
        for city in cityList {
            group.enter()
            APIManager.sharedManager.getWeatherData(forCity: city, and: { (cityWeatherData, error) in
                if let weatherData = cityWeatherData {
                    weatherReports.append(weatherData)
                    group.leave()
                }
            })
        }
        group.notify(queue: DispatchQueue.main) {
            self.updateDB(with: weatherReports)
            completion(weatherReports, nil)
        }
    }
    
    func refreshWeatherReport() {
        
    }
    
    // Update Database as per Response received For PageId
    
    func updateDB(with weatherData: [WeatherReportModel]?) -> Void {

        //Update Or Insert New Widgets
        if let weatherModels = weatherData {
            for weatherModel in weatherModels {
                CoreStore.perform(asynchronous: { (transaction) -> Void in
                    let weatherTuple = transaction.create(Into<WeatherInfo>())
                    weatherTuple.coordinates = NSKeyedArchiver.archivedData(withRootObject: weatherModel.coordinates!) as Data
                    weatherTuple.cod = Int64(exactly: NSNumber(value: weatherModel.cod ?? 0))!
                    weatherTuple.base = weatherModel.base!
                    weatherTuple.clouds = NSKeyedArchiver.archivedData(withRootObject: weatherModel.clouds!) as Data
                    weatherTuple.dt = Int64(exactly: NSNumber(value: weatherModel.dt ?? 0))!
                    weatherTuple.id = Int64(exactly: NSNumber(value: weatherModel.id ?? 0))!
                    weatherTuple.mainAttributes = NSKeyedArchiver.archivedData(withRootObject: weatherModel.mainAttributes!) as Data
                    weatherTuple.name = weatherModel.name!
                    weatherTuple.system = NSKeyedArchiver.archivedData(withRootObject: weatherModel.system!) as Data
                    weatherTuple.visibility = Int64(exactly: NSNumber(value: weatherModel.visibility ?? 0))!
                    weatherTuple.wind = NSKeyedArchiver.archivedData(withRootObject: weatherModel.wind!) as Data
                    weatherTuple.weather = NSKeyedArchiver.archivedData(withRootObject: weatherModel.weather!) as Data

                }, completion: { (result) -> Void in
                    switch result {
                    case .success: print("success!")
                    case .failure(let error): print(error)
                    }
                })
            }
        }
    }
    
    func fetchWeatherData(with completion: @escaping([WeatherReportModel]?, Error?) -> Void) {
        let weatherData = CoreStore.queryAttributes(From <WeatherInfo>(), Select ("coordinates", "weather", "base", "mainAttributes", "visibility", "wind", "clouds", "dt", "system", "id", "name", "cod"),Tweak{ (fetchRequest) -> Void in
            fetchRequest.includesPendingChanges = false
            fetchRequest.resultType = .dictionaryResultType
        })
        if let weatherDataArray = weatherData, (weatherDataArray.count) > 0 {
            let weatherModels = Mapper<WeatherReportModel>().mapArray(JSONArray: weatherDataArray)
            var index = 0
            for weatherModel in weatherModels {
                let aWeatherData = weatherDataArray[index]
                if let coordinateData = aWeatherData["coordinates"] as? Data, let unarchivedData = NSKeyedUnarchiver.unarchiveObject(with: coordinateData) as? Coord {
                    weatherModel.coordinates = unarchivedData
                }
                if let cloudsData = aWeatherData["clouds"] as? Data, let unarchivedData = NSKeyedUnarchiver.unarchiveObject(with: cloudsData) as? Clouds {
                    weatherModel.clouds = unarchivedData
                }
                if let mainAttributesData = aWeatherData["mainAttributes"] as? Data, let unarchivedData = NSKeyedUnarchiver.unarchiveObject(with: mainAttributesData) as? Main {
                    weatherModel.mainAttributes = unarchivedData
                }
                if let systemData = aWeatherData["system"] as? Data, let unarchivedData = NSKeyedUnarchiver.unarchiveObject(with: systemData) as? Sys {
                    weatherModel.system = unarchivedData
                }
                if let windData = aWeatherData["wind"] as? Data, let unarchivedData = NSKeyedUnarchiver.unarchiveObject(with: windData) as? Wind {
                    weatherModel.wind = unarchivedData
                }
                if let weatherData = aWeatherData["weather"] as? Data, let unarchivedData = NSKeyedUnarchiver.unarchiveObject(with: weatherData) as? [Weather] {
                    weatherModel.weather = unarchivedData
                }
                index += 1
            }
            completion(weatherModels, nil)
        }
    }
}
