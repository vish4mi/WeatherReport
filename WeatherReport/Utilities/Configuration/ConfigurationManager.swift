//
//  ConfigurationManager.swift
//  WeatherReport
//
//  Created by Vishal on 29/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import UIKit
import ObjectMapper

class ConfigurationManager: NSObject {
    
    var environment : Environment?
    
    // Singleton method
    static let sharedManager: ConfigurationManager = {
        let instance = ConfigurationManager()
        // setup code
        return instance
    }()
    
    override init() {
        super.init()
        initialize()
    }
    
    // Private method
    func initialize ()   {
        
        //load the environment settings
        environment = currentConfiguration()
        if environment == nil {
            
            assertionFailure(NSLocalizedString("Unable to load application configuration", comment: "Unable to load application configuration"))
        }
    }
    
    // currentConfiguration
    private func currentConfiguration () -> Environment   {
        
        let configuration = prodEnvironment
        // apply rule for loading test and UAT configuration (production is default)
        //configuration = test4Environment
        return configuration
    }
    
    /// API Endpoint
    ///
    /// - Returns: Base URL for the current configuration
    func APIEndpoint () -> String  {
        return (environment?.apiEndPoint)!
    }
}
