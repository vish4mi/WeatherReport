//
//  WeatherListViewModel.swift
//  WeatherReport
//
//  Created by Vishal on 30/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation

class WeatherListViewModel: NSObject, WeatherListViewModelProtocol {
    
    var cityTemp: Dynamic<String>
    var cityName: Dynamic<String>
    
    init(with weatherModel: WeatherReportModel?) {
        cityName = Dynamic(WeatherListViewModel.getCityName(forWeatherModel: weatherModel))
        cityTemp = Dynamic(WeatherListViewModel.getCityTemp(forWeatherModel: weatherModel))
    }
    
    fileprivate static func getCityName(forWeatherModel aViewModel: WeatherReportModel?) -> String {
        if let weatherReportModel = aViewModel, let name = weatherReportModel.name {
            return name
        }
        return ""
    }
    
    fileprivate static func getCityTemp(forWeatherModel aViewModel: WeatherReportModel?) -> String {
        if let weatherReportModel = aViewModel, let mainAttribs = weatherReportModel.mainAttributes, let temp = mainAttribs.temp {
            return "\(temp)"
        }
        return ""
    }
}
