//
//  WeatherListViewModelProtocol.swift
//  WeatherReport
//
//  Created by Vishal on 01/05/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation

protocol WeatherListViewModelProtocol {
    var cityTemp: Dynamic<String> { get }
    var cityName: Dynamic<String> { get }
}
