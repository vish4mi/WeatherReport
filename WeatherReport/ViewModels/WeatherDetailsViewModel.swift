//
//  WeatherDetailsViewModel.swift
//  WeatherReport
//
//  Created by Vishal on 30/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation

class WeatherDetailsViewModel: NSObject {
    var cityTemp: String?
    var cityName: String?
    var weatherConditionCode: Int?
    var weatherConditionDesc: String?
    var weatherConditionIcon: String?
    var name: String?
    var cloudCoverArea: Int?
    var longitude: String?
    var latitude: String?
    var tempCurrent: String?
    var pressure: String?
    var humidity: String?
    var tempMinimun: String?
    var tempMaximum: String?
    var type: Int?
    var message: Double?
    var country: String?
    var sunrise: String?
    var sunset: String?
    var windSpeed: String?
    var windDegree: String?
    var windDescription: String?

    init(with weatherModel: WeatherReportModel?) {
        if let weatherReportModel = weatherModel {
            if let main = weatherReportModel.mainAttributes, let temp = main.temp {
                cityTemp = "\(temp)" + " " + Constants.DEGREE_CELCIUS
            }
            if let name = weatherReportModel.name {
                cityName = name
            }
            if let weatherInfo = weatherReportModel.weather, weatherInfo.count > 0 {
                if let weatherCode = weatherInfo[0].weatherConditionCode {
                    weatherConditionCode = weatherCode
                }
                if let weatherDesc = weatherInfo[0].description {
                    weatherConditionDesc = weatherDesc.capitalizingFirstLetter()
                }
                if let weatherIcon = weatherInfo[0].icon {
                    weatherConditionIcon = weatherIcon
                }
            }
            if let coordinates = weatherReportModel.coordinates {
                if let aLatitude = coordinates.latitude {
                    latitude = "\(aLatitude)" + Constants.DEGREE
                }
                if let aLongitude = coordinates.longitude {
                    longitude = "\(aLongitude)" + Constants.DEGREE
                }
            }
            if let mainAttributes = weatherReportModel.mainAttributes {
                if let currentTemp = mainAttributes.temp {
                    tempCurrent = "\(currentTemp)" + " " + Constants.DEGREE_CELCIUS
                }
                if let minTemp = mainAttributes.tempMin {
                    tempMinimun = "\(minTemp)" + " " + Constants.DEGREE_CELCIUS
                }
                if let maxTemp = mainAttributes.tempMax {
                    tempMaximum = "\(maxTemp)" + " " + Constants.DEGREE_CELCIUS
                }
                if let pressureValue = mainAttributes.seaLevelPressure {
                    pressure = "\(pressureValue)" + " " + "hPa"
                } else if let pressureValue = mainAttributes.pressure {
                    pressure = "\(pressureValue)" + " " + "hPa"
                }
                if let humidityValue = mainAttributes.humidity {
                    humidity = "\(humidityValue)" + " " + "%"
                }
            }
            if let windAttributes = weatherReportModel.wind {
                windDescription = "Wind is running"
                if let speed = windAttributes.speed {
                    windSpeed = "\(speed)"
                    windDescription = windDescription! + " " + "at \(speed) m/s"
                }
                if let degree = windAttributes.degree {
                    windDegree = "\(degree)"
                    windDescription = windDescription! + " " + "at \(degree)" + Constants.DEGREE
                }
            }
        }
    }
}
