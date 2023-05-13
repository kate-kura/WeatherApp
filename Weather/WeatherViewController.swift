//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Екатерина on 26.12.2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    var weatherService = WeatherService()
    let locationManager = CLLocationManager()
    
    let backgroundView = UIImageView()
    
    let weatherStackView = UIStackView()
    let temperatureStackView = UIStackView()
    let oneMoreStackView = UIStackView()
    let cityLabel = UILabel()
    let conditionImageView = UIImageView()
    let temperatureLabel = UILabel()
    let descriptionLabel = UILabel()
    let feelsLikeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupStyle()
        setupLayout()
    }
}

extension WeatherViewController {
    
    func setup() {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
                
        weatherService.delegate = self
        
    }
    
    func setupStyle() {
        
        self.navigationController?.isNavigationBarHidden = true
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.tintColor = Resources.Colors.background
        backgroundView.image = UIImage(named: "background")
        backgroundView.contentMode = .scaleAspectFill
        
        weatherStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherStackView.axis = .vertical
        weatherStackView.alignment = .center
        weatherStackView.spacing = 32
        
        temperatureStackView.translatesAutoresizingMaskIntoConstraints = false
        temperatureStackView.axis = .horizontal
        temperatureStackView.alignment = .center
        temperatureStackView.spacing = 16
        
        oneMoreStackView.translatesAutoresizingMaskIntoConstraints = false
        oneMoreStackView.axis = .vertical
        oneMoreStackView.alignment = .center
        oneMoreStackView.spacing = 8
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = .boldSystemFont(ofSize: 42)
        
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.tintColor = .label
        conditionImageView.contentMode = .scaleAspectFit
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = .boldSystemFont(ofSize: 72)
                
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
    }

        
    func setupLayout() {
        
        temperatureStackView.addArrangedSubview(temperatureLabel)
        temperatureStackView.addArrangedSubview(conditionImageView)
        
        oneMoreStackView.addArrangedSubview(temperatureStackView)
        oneMoreStackView.addArrangedSubview(descriptionLabel)
        oneMoreStackView.addArrangedSubview(feelsLikeLabel)
        
        weatherStackView.addArrangedSubview(cityLabel)
        weatherStackView.addArrangedSubview(oneMoreStackView)
        
        view.addSubview(backgroundView)
        view.addSubview(weatherStackView)
        
        NSLayoutConstraint.activate([
            
            weatherStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            weatherStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: weatherStackView.trailingAnchor, multiplier: 1),
            
            conditionImageView.heightAnchor.constraint(equalToConstant: 100),
            conditionImageView.widthAnchor.constraint(equalToConstant: 100),

            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherService.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


// MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherServiceDelegate {
    
    func didFetchWeather(_ weatherService: WeatherService, _ weather: WeatherModel) {
        self.cityLabel.text = weather.cityName
        self.temperatureLabel.text = weather.temperatureString
        self.conditionImageView.image = UIImage(systemName: weather.conditionIcon)
        self.descriptionLabel.text = weather.dedcription
        self.feelsLikeLabel.text = weather.feelsLikeString
    }
    
    func didFailWithError(_ weatherService: WeatherService, _ error: WeatherServiceError) {
        let message: String
        
        switch error {
        case .network(statusCode: let statusCode):
            message = "Networking error. Status code: \(statusCode)."
        case .parsing:
            message = "JSON weather data could not be parsed."
        case .general(reason: let reason):
            message = reason
        }
        showErrorAlert(with: message)
    }
    
    func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error fetching weather",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

