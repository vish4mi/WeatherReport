//
//  UIView+Extension.swift
//  GithubRepo
//
//  Created by Vishal on 28/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIView {
    func showActivityIndicator() {
        let activityView = MBProgressHUD.showAdded(to: self, animated: true)
        activityView.removeFromSuperViewOnHide = true
    }
    
    func hideActivityIndicator() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}
