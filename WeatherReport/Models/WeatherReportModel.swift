//
//  WeatherReportModel.swift
//  WeatherReport
//
//  Created by Vishal on 29/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherReportModel {
    var coordinates: Coord?
    var weather: [Weather]?
    var base: String?
    var mainAttributes: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var system: Sys?
    var id: Int?
    var name: String?
    var cod: Int?
    
    // Mappable
    func mapping(map: Map) {
        coordinates    <- map["coord"]
        weather        <- map["weather"]
        base           <- map["base"]
        mainAttributes <- map["main"]
        visibility     <- map["visibility"]
        wind           <- map["wind"]
        clouds         <- map["clouds"]
        dt             <- map["dt"]
        system         <- map["sys"]
        id             <- map["id"]
        name           <- map["name"]
        cod            <- map["cod"]

    }
}

class Clouds {
    var all: Int?
    
    // Mappable
    func mapping(map: Map) {
        all    <- map["all"]
    }
}

class Coord {
    var longitude: Double?
    var latitude: Double?
    
    // Mappable
    func mapping(map: Map) {
        longitude    <- map["lon"]
        latitude     <- map["lat"]
    }
}

class Main {
    var temp: Double?
    var pressure: Int?
    var humidity: Int?
    var tempMin: Double?
    var tempMax: Double?
    
    // Mappable
    func mapping(map: Map) {
        temp     <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        tempMin  <- map["tempMin"]
        tempMax  <- map["tempMax"]
    }
}

class Sys {
    var type: Int?
    var id: Int?
    var message: Double?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
    
    // Mappable
    func mapping(map: Map) {
        type    <- map["type"]
        id      <- map["id"]
        message <- map["message"]
        country <- map["country"]
        sunrise <- map["sunrise"]
        sunset  <- map["sunset"]
    }
}

class Weather {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    // Mappable
    func mapping(map: Map) {
        id          <- map["id"]
        main        <- map["main"]
        description <- map["description"]
        icon        <- map["icon"]
    }
}

class Wind {
    var speed: Double?
    var degree: Int?
    
    // Mappable
    func mapping(map: Map) {
        speed  <- map["speed"]
        degree <- map["deg"]
    }
}

