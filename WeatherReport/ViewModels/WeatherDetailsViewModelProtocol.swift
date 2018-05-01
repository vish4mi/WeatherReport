//
//  WeatherDetailsViewModelProtocol.swift
//  WeatherReport
//
//  Created by Vishal on 01/05/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation

protocol WeatherDetailsViewModelProtocol {
    
    var weatherConditionCode: Dynamic<Int> { get }
    var weatherConditionDesc: Dynamic<String> { get }
    var weatherConditionIcon: Dynamic<String> { get }
    var weatherIconURL: Dynamic<String> { get }
    var cityName: Dynamic<String> { get }
    var cloudCoverArea: Dynamic<Int> { get }
    var longitude: Dynamic<String> { get }
    var latitude: Dynamic<String> { get }
    var tempCurrent: Dynamic<String> { get }
    var pressure: Dynamic<String> { get }
    var humidity: Dynamic<String> { get }
    var tempMinimun: Dynamic<String> { get }
    var tempMaximum: Dynamic<String> { get }
    var type: Dynamic<Int> { get }
    var message: Dynamic<Double> { get }
    var country: Dynamic<String> { get }
    var sunrise: Dynamic<String> { get }
    var sunset: Dynamic<String> { get }
    var windSpeed: Dynamic<String> { get }
    var windDegree: Dynamic<String> { get }
    var windDescription: Dynamic<String> { get }
    
}
