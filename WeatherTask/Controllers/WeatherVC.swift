//
//  ViewController.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//

import UIKit

class WeatherVC: BaseVC {

    //MARK: Outlets
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentWeatherType: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var highTemperature: UILabel!
    @IBOutlet weak var lowTemperature: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var humidity: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    
    private var viewModel: WeatherViewModel!

    // MARK: UIController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getWeatherData()
    }
}

private extension WeatherVC {
    func setupUI() {
        
        viewModel = WeatherViewModel()
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.tableFooterView =  UIView()
        tableView.dataSource = self
        tableView.registerNib(cell: ForecastCell.self)
    }
    
    func getWeatherData() {
        showLoader()
        viewModel.fetchWeatherData { [weak self] errorMessage, error in
            
            guard let self = self else { return }
            
            if let errorMessage = errorMessage {
                DispatchQueue.main.async {
                    self.presentAlert(Constants.failure, nil, errorMessage)
                }
            } else {
                self.viewModel.fetchForecastData { errorMessage, error in
                    
                    DispatchQueue.main.async {
                        self.dismissLoader()
                        if let error = error {
                            self.presentAlert(Constants.failure, error)
                        }
                        
                        if let errorMessage = errorMessage {
                            self.presentAlert(Constants.failure, nil, errorMessage)
                        }
                        
                        !self.viewModel.weather.isNil ? self.updateUI() : ()
                        self.viewModel.forecast.count > 0 ? self.tableView.reloadData() : ()
                    }
                }
            }
        }
    }
    
    func updateUI() {
        
        if let model = viewModel.weather {
            location.text = model.name
            currentTemperature.text = viewModel.tempConversion(for: model.main.temp)
            date.text = Date().toString()
            highTemperature.text =  viewModel.tempConversion(for: model.main.tempMax)
            lowTemperature.text =  viewModel.tempConversion(for: model.main.tempMin)
            humidity.text =  "\(model.main.humidity)%"
            feelsLike.text =  viewModel.tempConversion(for: model.main.feelsLike)
            
            if model.weather.count > 0 {
                let weather = model.weather[0]
                currentWeatherType.text = "\(weather.main)"
                ImageProvider.getImage(urlString: Constants.imageUrlString(iconCode: weather.icon)) { image, error in
                    if let image = image {
                        self.currentWeatherIcon.image = image
                    }
                }
            }
        }
    }
}

extension WeatherVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ForecastCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.forecast = viewModel.forecast[indexPath.row]
        return cell
    }
}

