//
//  Constants.swift
//  WeatherReport
//
//  Created by Vishal on 29/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation

struct Constants {
    static let CITY_ID_SYDNEY = "4163971"
    static let CITY_ID_MELBOURNE = "2147714"
    static let CITY_ID_BRISBANE = "2174003"
    
    // ºC code constant
    static let DEGREE_CELCIUS = "\u{00B0}C"
    static let DEGREE = "\u{00B0}"
    static let PERCENTAGE = "%"
    static let PRESSURE_METRIC = "hPa"

    static let API_KEY = "cb52710deceb1825a876c92222a53064"
    
    static let BASEURL = ConfigurationManager.sharedManager.APIEndpoint();
    static let WEATHER_ICON_URL = "http://openweathermap.org/img/w/{WeatherIcon}.png"
    static let TEMP_GIF_URL = "http://www.animatedimages.org/data/media/148/animated-weather-image-0111.gif"
    static let WINDMILL_GIF_URL = "http://www.animatedimages.org/data/media/150/animated-windmill-image-0015.gif"
    
    //MARK: APIServiceMethods
    struct APIServiceMethods {
        static let weatherReportAPI = Constants.APIServiceMethods.apiURL(methodName: "/data/2.5/weather?id={CITY_ID}&units=metric&APPID=\(API_KEY)")
        
        static func apiURL(methodName: String) -> String {
            var baseURL = Constants.BASEURL
            if baseURL.hasSuffix("/") {
                baseURL = String(baseURL[...baseURL.index(before: baseURL.endIndex)])
            }
            var path = methodName
            if path.hasPrefix("/") {
                path = String(path[path.index(after: baseURL.startIndex)...])
            }
            return "\(baseURL)/\(path)"
        }
    }
    
    /// Segue identifiers
    static let SHOW_WEATHER_DETAILS_VC_SEGUE = "showWeatherDetailsVCSegue"
    
}
