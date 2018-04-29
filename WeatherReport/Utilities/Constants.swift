//
//  Constants.swift
//  GithubRepo
//
//  Created by Vishal on 26/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation

struct Constants {
    static let BASEURL = ConfigurationManager.sharedManager.APIEndpoint();
    
    //MARK: APIServiceMethods
    struct APIServiceMethods {
        static let searchRepoAPI = Constants.APIServiceMethods.apiURL(methodName: "/data/2.5/weather?id={CITY_ID}}&units=metric&APPID={API_KEY}}")
        
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
    static let SHOW_REPO_LIST_VC_SEGUE = "showGitHubRepoListSegue"
    static let SHOW_WEATHER_DETAILS_VC_SEGUE = "showWeatherDetailsVCSegue"
    
}
