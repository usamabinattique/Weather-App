//
//  WeatherCell.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    
    var forecast: Forecast! {
        didSet {
            highTemp.text = convertTemp(temp: forecast.temp.max, from: .kelvin, to: .celsius)

            lowTemp.text = convertTemp(temp: forecast.temp.min, from: .kelvin, to: .celsius)
            feelsLike.text = forecast.feelsLike.day.stringValue
            humidity.text = "\(forecast.humidity)%"
            weatherType.text = forecast.weather[0].main
            
            ImageProvider.getImage(urlString: Constants.imageUrlString(iconCode: forecast.weather[0].icon)) { [unowned self] image, error in
                if let image = image {
                    self.weatherIcon.image = image
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
}