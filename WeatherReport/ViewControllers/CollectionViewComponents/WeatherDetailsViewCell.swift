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
    
    func configure() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        
       tempImageView.kf.setImage(with: URL(string: "http://www.animatedimages.org/data/media/148/animated-weather-image-0111.gif"), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        windImageView.kf.setImage(with: URL(string: "http://www.animatedimages.org/data/media/150/animated-windmill-image-0015.gif"), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)

    }
    
    func setupCell(with weatherDetailModel: WeatherDetailsViewModel?) {
        if let weatherDetailsViewModel = weatherDetailModel {
            if let currentTemp = weatherDetailsViewModel.tempCurrent {
                currentTempLabel.text = "\(currentTemp)"
            }
            if let maxTemp = weatherDetailsViewModel.tempMaximum {
                maxTempLabel.text = "\(maxTemp)"
            }
            if let minTemp = weatherDetailsViewModel.tempMinimun {
                minTempLabel.text = "\(minTemp)"
            }
            if let weatherIcon = weatherDetailsViewModel.weatherConditionIcon {
                let iconURL = URL(string: "http://openweathermap.org/img/w/\(weatherIcon).png")
                weatherImageView.kf.setImage(with: iconURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }
            if let weatherDesc = weatherDetailsViewModel.weatherConditionDesc {
                weatherDescLabel.text = weatherDesc
            }
            if let windDescription = weatherDetailsViewModel.windDescription {
                windDescLabel.text = windDescription
            }
            if let longitude = weatherDetailsViewModel.longitude {
                longitudeLabel.text = "\(longitude)"
            }
            if let latitude = weatherDetailsViewModel.latitude {
                latitudeLabel.text = "\(latitude)"
            }
            if let pressureValue = weatherDetailsViewModel.pressure {
                pressureLabel.text = pressureValue
            }
            if let humidityValue = weatherDetailsViewModel.humidity {
                humidityLabel.text = humidityValue
            }
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
