//
//  WeatherDetailsViewCell.swift
//  WeatherReport
//
//  Created by Vishal on 30/04/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import UIKit
import Kingfisher

class WeatherDetailsViewCell: UICollectionViewCell {
 
    @IBOutlet weak var sunSetImageView: UIImageView!
    @IBOutlet weak var sunRiseImageView: UIImageView!
    @IBOutlet weak var weatherImageView: AnimatedImageView!
    @IBOutlet weak var tempImageView: AnimatedImageView!
    @IBOutlet weak var windImageView: AnimatedImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var windDescLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var sunRiseLabel: UILabel!
    @IBOutlet weak var sunSetLabel: UILabel!
    
    func configure() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        
       tempImageView.kf.setImage(with: URL(string: Constants.TEMP_GIF_URL), placeholder: UIImage(named: "thermometer.png"), options: nil, progressBlock: nil, completionHandler: nil)
        windImageView.kf.setImage(with: URL(string: Constants.WINDMILL_GIF_URL), placeholder: UIImage(named: "windmill.png"), options: nil, progressBlock: nil, completionHandler: nil)
        sunRiseImageView.kf.setImage(with: URL(string: Constants.SUNRISE_GIF_URL), placeholder: UIImage(named: "sunrise.png"), options: nil, progressBlock: nil, completionHandler: nil)
        sunSetImageView.kf.setImage(with: URL(string: Constants.SUNSET_GIF_URL), placeholder: UIImage(named: "sunset.png"), options: nil, progressBlock: nil, completionHandler: nil)

    }
    
    func setupCell(with weatherDetailModel: WeatherDetailsViewModel?) {
        if let weatherDetailsViewModel = weatherDetailModel {
            currentTempLabel.text = weatherDetailsViewModel.tempCurrent.value
            maxTempLabel.text = weatherDetailsViewModel.tempMaximum.value
            minTempLabel.text = weatherDetailsViewModel.tempMinimun.value
            let iconURL = URL(string: weatherDetailsViewModel.weatherIconURL.value)
            weatherImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "cloud.png"), options: nil, progressBlock: nil, completionHandler: nil)
            weatherDescLabel.text = weatherDetailsViewModel.weatherConditionDesc.value
            windDescLabel.text = weatherDetailsViewModel.windDescription.value
            longitudeLabel.text = weatherDetailsViewModel.longitude.value
            latitudeLabel.text = weatherDetailsViewModel.latitude.value
            pressureLabel.text = weatherDetailsViewModel.pressure.value
            humidityLabel.text = weatherDetailsViewModel.humidity.value
            sunRiseLabel.text = weatherDetailsViewModel.sunrise.value
            sunSetLabel.text = weatherDetailsViewModel.sunset.value
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
     
    }
    
    override open var isSelected: Bool {
        set {
        }
        get {
            return super.isSelected
        }
    }
    
    override open var isHighlighted: Bool{
        set {
        }
        get {
            return super.isHighlighted
        }
    }
}
