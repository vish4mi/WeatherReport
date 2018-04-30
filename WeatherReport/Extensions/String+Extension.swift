//
//  String+Extension.swift
//  WeatherReport
//
//  Created by Vishal on 01/05/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
