//
//  UIView+Extension.swift
//  WeatherReport
//
//  Created by Vishal on 29/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIView {
    func showActivityIndicator() {
        let activityView = MBProgressHUD.showAdded(to: self, animated: true)
        activityView.label.text = "Please wait..".localizedCapitalized
        activityView.removeFromSuperViewOnHide = true

    }
    
    func hideActivityIndicator() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}
