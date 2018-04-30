//
//  WeatherListViewModel.swift
//  WeatherReport
//
//  Created by Vishal on 30/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation

class WeatherListViewModel: NSObject {
    var cityTemp: Double?
    var cityName: String?
    
    init(with weatherModel: WeatherReportModel?) {
        if let weatherReportModel = weatherModel {
            if let main = weatherReportModel.mainAttributes, let temp = main.temp {
                cityTemp = temp
            }
            if let name = weatherReportModel.name {
                cityName = name
            }
        }
    }
}
