//
//  WeatherReportModel.swift
//  WeatherReport
//
//  Created by Vishal on 29/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherReportModel: NSObject, NSCoding, Mappable {
    
    override init() {
    }
    
    required init?(map: Map) {
    }
    
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
    
    required init(coder decoder: NSCoder) {
        coordinates = (decoder.decodeObject(forKey: "coordinates") as? Coord)
        weather = (decoder.decodeObject(forKey: "weather") as? [Weather])
        base = (decoder.decodeObject(forKey: "base") as? String)
        mainAttributes = (decoder.decodeObject(forKey: "mainAttributes") as? Main)
        visibility = (decoder.decodeObject(forKey: "visibility") as? Int)
        wind = (decoder.decodeObject(forKey: "wind") as? Wind)
        clouds = (decoder.decodeObject(forKey: "clouds") as? Clouds)
        dt = (decoder.decodeObject(forKey: "dt") as? Int)
        system = (decoder.decodeObject(forKey: "system") as? Sys)
        id = (decoder.decodeObject(forKey: "id") as? Int)
        name = (decoder.decodeObject(forKey: "name") as? String)
        cod = (decoder.decodeObject(forKey: "cod") as? Int)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(coordinates, forKey: "coordinates")
        aCoder.encode(weather, forKey: "weather")
        aCoder.encode(base, forKey: "base")
        aCoder.encode(mainAttributes, forKey: "mainAttributes")
        aCoder.encode(visibility, forKey: "visibility")
        aCoder.encode(wind, forKey: "wind")
        aCoder.encode(clouds, forKey: "clouds")
        aCoder.encode(dt, forKey: "dt")
        aCoder.encode(system, forKey: "system")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(cod, forKey: "cod")
    }
}

class Clouds: NSObject, NSCoding, Mappable {
    var cloudCoverArea: Int?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        cloudCoverArea <- map["all"]
    }
    
    required init(coder decoder: NSCoder) {
        cloudCoverArea = (decoder.decodeObject(forKey: "cloudCoverArea") as? Int)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(cloudCoverArea, forKey: "cloudCoverArea")
    }
}

class Coord: NSObject, NSCoding, Mappable {
    var longitude: Double?
    var latitude: Double?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        longitude    <- map["lon"]
        latitude     <- map["lat"]
    }
    
    required init(coder decoder: NSCoder) {
        longitude = (decoder.decodeObject(forKey: "longitude") as? Double)
        latitude = (decoder.decodeObject(forKey: "latitude") as? Double)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(longitude, forKey: "longitude")
        aCoder.encode(latitude, forKey: "latitude")
    }
}

class Main: NSObject, NSCoding, Mappable {
    var temp: Double?
    var pressure: Int?
    var humidity: Int?
    var tempMin: Double?
    var tempMax: Double?
    var seaLevelPressure: Int?
    var groundLevelPressure: Int?

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        temp     <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        tempMin  <- map["temp_min"]
        tempMax  <- map["temp_max"]
        seaLevelPressure     <- map["sea_level"]
        groundLevelPressure  <- map["grnd_level"]
    }
    
    required init(coder decoder: NSCoder) {
        temp = (decoder.decodeObject(forKey: "temp") as? Double)
        pressure = (decoder.decodeObject(forKey: "pressure") as? Int)
        humidity = (decoder.decodeObject(forKey: "humidity") as? Int)
        tempMin = (decoder.decodeObject(forKey: "tempMin") as? Double)
        tempMax = (decoder.decodeObject(forKey: "tempMax") as? Double)
        seaLevelPressure = (decoder.decodeObject(forKey: "seaLevelPressure") as? Int)
        groundLevelPressure = (decoder.decodeObject(forKey: "groundLevelPressure") as? Int)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(temp, forKey: "temp")
        aCoder.encode(pressure, forKey: "pressure")
        aCoder.encode(humidity, forKey: "humidity")
        aCoder.encode(tempMin, forKey: "tempMin")
        aCoder.encode(tempMax, forKey: "tempMax")
        aCoder.encode(seaLevelPressure, forKey: "seaLevelPressure")
        aCoder.encode(groundLevelPressure, forKey: "groundLevelPressure")
    }
}

class Sys: NSObject, NSCoding, Mappable {
    var type: Int?
    var id: Int?
    var message: Double?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        type    <- map["type"]
        id      <- map["id"]
        message <- map["message"]
        country <- map["country"]
        sunrise <- map["sunrise"]
        sunset  <- map["sunset"]
    }
    
    required init(coder decoder: NSCoder) {
        type = (decoder.decodeObject(forKey: "type") as? Int)
        id = (decoder.decodeObject(forKey: "id") as? Int)
        message = (decoder.decodeObject(forKey: "message") as? Double)
        country = (decoder.decodeObject(forKey: "country") as? String)
        sunrise = (decoder.decodeObject(forKey: "sunrise") as? Int)
        sunset = (decoder.decodeObject(forKey: "sunset") as? Int)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(type, forKey: "type")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(message, forKey: "message")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(sunrise, forKey: "sunrise")
        aCoder.encode(sunset, forKey: "sunset")
    }
}

class Weather: NSObject, NSCoding, Mappable {
    var weatherConditionCode: Int?
    var main: String?
    var weatherDesc: String?
    var icon: String?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        weatherConditionCode <- map["id"]
        main                 <- map["main"]
        weatherDesc          <- map["description"]
        icon                 <- map["icon"]
    }
    
    required init(coder decoder: NSCoder) {
        weatherConditionCode = (decoder.decodeObject(forKey: "weatherConditionCode") as? Int)
        main = (decoder.decodeObject(forKey: "main") as? String)
        weatherDesc = (decoder.decodeObject(forKey: "weatherDesc") as? String)
        icon = (decoder.decodeObject(forKey: "icon") as? String)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(weatherConditionCode, forKey: "weatherConditionCode")
        aCoder.encode(main, forKey: "main")
        aCoder.encode(weatherDesc, forKey: "weatherDesc")
        aCoder.encode(icon, forKey: "icon")
    }
}

class Wind: NSObject, NSCoding, Mappable {
    var speed: Double?
    var degree: Int?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        speed  <- map["speed"]
        degree <- map["deg"]
    }
    
    required init(coder decoder: NSCoder) {
        speed = (decoder.decodeObject(forKey: "speed") as? Double)
        degree = (decoder.decodeObject(forKey: "degree") as? Int)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(degree, forKey: "degree")
        aCoder.encode(speed, forKey: "speed")
    }
}

