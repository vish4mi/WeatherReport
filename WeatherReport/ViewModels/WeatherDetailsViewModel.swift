//
//  WeatherDetailsViewModel.swift
//  WeatherReport
//
//  Created by Vishal on 30/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation

class WeatherDetailsViewModel: NSObject, WeatherDetailsViewModelProtocol {
    var weatherConditionCode: Dynamic<Int>
    var weatherConditionDesc: Dynamic<String>
    var weatherConditionIcon: Dynamic<String>
    var weatherIconURL: Dynamic<String>
    var cityName: Dynamic<String>
    var cloudCoverArea: Dynamic<Int>
    var longitude: Dynamic<String>
    var latitude: Dynamic<String>
    var tempCurrent: Dynamic<String>
    var pressure: Dynamic<String>
    var humidity: Dynamic<String>
    var tempMinimun: Dynamic<String>
    var tempMaximum: Dynamic<String>
    var type: Dynamic<Int>
    var message: Dynamic<Double>
    var country: Dynamic<String>
    var sunrise: Dynamic<String>
    var sunset: Dynamic<String>
    var windSpeed: Dynamic<String>
    var windDegree: Dynamic<String>
    var windDescription: Dynamic<String>

    init(with weatherModel: WeatherReportModel?) {
        cityName = Dynamic(WeatherDetailsViewModel.getCityName(forViewModel: weatherModel))
        tempCurrent = Dynamic(WeatherDetailsViewModel.getCurrentTemp(forViewModel: weatherModel))
        tempMinimun = Dynamic(WeatherDetailsViewModel.getMinimumTemp(forViewModel: weatherModel))
        tempMaximum = Dynamic(WeatherDetailsViewModel.getMaximumTemp(forViewModel: weatherModel))
        weatherConditionCode = Dynamic(WeatherDetailsViewModel.getWeatherConditionCode(forViewModel: weatherModel))
        weatherConditionDesc = Dynamic(WeatherDetailsViewModel.getWeatherDescription(forViewModel: weatherModel))
        weatherConditionIcon = Dynamic(WeatherDetailsViewModel.getWeatherIcon(forViewModel: weatherModel))
        weatherIconURL = Dynamic(WeatherDetailsViewModel.getWeatherIconURL(forViewModel: weatherModel))
        latitude = Dynamic(WeatherDetailsViewModel.getLatitude(forViewModel: weatherModel))
        longitude = Dynamic(WeatherDetailsViewModel.getLongitude(forViewModel: weatherModel))
        cloudCoverArea = Dynamic(0)
        pressure = Dynamic(WeatherDetailsViewModel.getPressure(forViewModel: weatherModel))
        humidity = Dynamic(WeatherDetailsViewModel.getHumidity(forViewModel: weatherModel))
        type = Dynamic(0)
        message = Dynamic(0)
        country = Dynamic("")
        sunrise = Dynamic("")
        sunset = Dynamic("")
        windSpeed = Dynamic("")
        windDegree = Dynamic("")
        windDescription = Dynamic("")
    }
    
    fileprivate static func getCurrentTemp(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let main = weatherReportModel.mainAttributes, let temp = main.temp {
            let currentTemp = "\(temp)" + " " + Constants.DEGREE_CELCIUS
            return currentTemp
        }
        return ""
    }
    
    fileprivate static func getMinimumTemp(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let main = weatherReportModel.mainAttributes, let minTemp = main.tempMin {
            let minimumTemp = "\(minTemp)" + " " + Constants.DEGREE_CELCIUS
            return minimumTemp
        }
        return ""
    }
    
    fileprivate static func getMaximumTemp(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let main = weatherReportModel.mainAttributes, let maxTemp = main.tempMax {
            let maximumTemp = "\(maxTemp)" + " " + Constants.DEGREE_CELCIUS
            return maximumTemp
        }
        return ""
    }
    
    fileprivate static func getCityName(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let name = weatherReportModel.name {
            return name
        }
        return ""
    }
    
    fileprivate static func getWeatherConditionCode(forViewModel weatherModel: WeatherReportModel?) -> Int {
        if let weatherReportModel = weatherModel, let weatherInfo = weatherReportModel.weather, weatherInfo.count > 0 {
            if let weatherCode = weatherInfo[0].weatherConditionCode {
                return weatherCode
            }
        }
        return 0
    }
    
    fileprivate static func getWeatherDescription(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let weatherInfo = weatherReportModel.weather, weatherInfo.count > 0 {
            if let weatherDesc = weatherInfo[0].weatherDesc {
                return weatherDesc.capitalizingFirstLetter()
            }
        }
        return ""
    }
    
    fileprivate static func getWeatherIconURL(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let weatherInfo = weatherReportModel.weather, weatherInfo.count > 0 {
            if let weatherIcon = weatherInfo[0].icon {
                var iconURL = Constants.WEATHER_ICON_URL
                iconURL = iconURL.replacingOccurrences(of: "{WeatherIcon}", with: weatherIcon)
                return iconURL
            }
        }
        return ""
    }
    
    fileprivate static func getWeatherIcon(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let weatherInfo = weatherReportModel.weather, weatherInfo.count > 0 {
            if let weatherIcon = weatherInfo[0].icon {
                return weatherIcon
            }
        }
        return ""
    }
    
    fileprivate static func getLongitude(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let coordinates = weatherReportModel.coordinates {
            if let aLongitude = coordinates.longitude {
                return "\(aLongitude)" + Constants.DEGREE
            }
        }
        return ""
    }
    
    fileprivate static func getLatitude(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let coordinates = weatherReportModel.coordinates {
            if let aLatitude = coordinates.latitude {
                return "\(aLatitude)" + Constants.DEGREE
            }
        }
        return ""
    }
    
    fileprivate static func getHumidity(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let mainAttributes = weatherReportModel.mainAttributes {
            if let humidityValue = mainAttributes.humidity {
                return "\(humidityValue)" + " " + Constants.PERCENTAGE
            }
        }
        return ""
    }
    
    fileprivate static func getPressure(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let mainAttributes = weatherReportModel.mainAttributes {
            if let pressureValue = mainAttributes.seaLevelPressure {
                return "\(pressureValue)" + " " + Constants.PRESSURE_METRIC
            } else if let pressureValue = mainAttributes.pressure {
                return "\(pressureValue)" + " " + Constants.PRESSURE_METRIC
            }
        }
        return ""
    }
    
    fileprivate static func getWindSpeed(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let windAttributes = weatherReportModel.wind {
            if let speed = windAttributes.speed {
                return "\(speed)"
            }
        }
        return ""
    }
    
    fileprivate static func getWindDirection(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let windAttributes = weatherReportModel.wind {
            if let degree = windAttributes.degree {
                return "\(degree)"
            }
        }
        return ""
    }
    
    fileprivate static func getWindDescription(forViewModel weatherModel: WeatherReportModel?) -> String {
        if let weatherReportModel = weatherModel, let windAttributes = weatherReportModel.wind {
            var windDescription = "Wind is running"
            if let speed = windAttributes.speed {
                windDescription = windDescription + " " + "at \(speed) m/s"
            }
            if let degree = windAttributes.degree {
                windDescription = windDescription + " " + "at \(degree)" + Constants.DEGREE
            }
            return windDescription
        }

        return ""
    }
}
