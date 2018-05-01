//
//  WeatherListTableViewCell.swift
//  WeatherReport
//
//  Created by Vishal on 30/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(withViewModel weatherListViewModel: WeatherListViewModel?) {
        if let weatherViewModel = weatherListViewModel {
            cityNameLabel.text = weatherViewModel.cityName.value
            cityTempLabel.text = weatherViewModel.cityTemp.value
        }
    }
}
