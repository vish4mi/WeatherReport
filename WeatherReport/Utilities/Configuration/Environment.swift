//
//  Environment.swift
//  GithubRepo
//
//  Created by Vishal on 26/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation
struct Environment {
    var name: String = ""
    var apiEndPoint: String = ""
}

//Production server configuration
let prodEnvironment = Environment(name: "production",
                                  apiEndPoint: "http://api.openweathermap.org")
