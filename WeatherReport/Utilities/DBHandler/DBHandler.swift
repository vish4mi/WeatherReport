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

class DBHandler: NSObject {
    
    let cityList = [Constants.CITY_ID_SYDNEY, Constants.CITY_ID_MELBOURNE, Constants.CITY_ID_BRISBANE]
    
    //MARK:  Set up Shared Instance
    // Set up Shared Instance
    static let sharedHandler: DBHandler = {
        let instance = DBHandler()
        // setup code
        return instance
    }()
    
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
            completion(weatherReports, nil)
        }
    }
    
    func refreshWeatherReport() {
        
    }
    
    // Update Database as per Response received For PageId
    
//    func updateDB(with moviesData: [MoviesModel]?) -> Void {
//
//        //Update Or Insert New Widgets
//        if let movieModels = moviesData {
//            for movieModel in movieModels {
//                CoreStore.perform(asynchronous: { (transaction) -> Void in
//                    let movieTuple = transaction.create(Into<Movie>())
//                    movieTuple.title = movieModel.title
//                    movieTuple.image = movieModel.image
//                    movieTuple.rating = movieModel.rating!
//                    movieTuple.releaseYear = movieModel.releaseYear!
//                    movieTuple.genre = NSKeyedArchiver.archivedData(withRootObject: movieModel.genre!) as Data
//                }, completion: { (result) -> Void in
//                    switch result {
//                    case .success: print("success!")
//                    case .failure(let error): print(error)
//                    }
//                })
//            }
//        }
//    }
    
//    func fetchMoviesData(with completion: @escaping([MoviesModel]?, Error?) -> Void) {
//        let moviesData = CoreStore.queryAttributes(From <Movie>(), Select ("title", "image", "rating", "releaseYear", "genre"),Tweak{ (fetchRequest) -> Void in
//            fetchRequest.includesPendingChanges = false
//            fetchRequest.resultType = .dictionaryResultType
//        })
//        if let movieDataArray = moviesData, (movieDataArray.count) > 0 {
//            let movieModels = Mapper<MoviesModel>().mapArray(JSONArray: movieDataArray)
//            var index = 0
//            for movieModel in movieModels {
//                let movieData = movieDataArray[index]
//                if let genreData = movieData["genre"] as? Data, let unarchivedData = NSKeyedUnarchiver.unarchiveObject(with: genreData) as? [String] {
//                    movieModel.genre = unarchivedData
//                    index += 1
//                }
//            }
//            completion(movieModels, nil)
//        }
//    }
}
