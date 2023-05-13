//
//  CityWeatherViewController.swift
//  WeatherApp
//
//  Created by Екатерина on 28.03.2023.
//

import UIKit

protocol CityWeatherViewControllerDelegate: AnyObject {
    func didPressCell(item: WeatherModel)
}

class CityWeatherViewController: UIViewController {
    
    weak var delegate: CityWeatherViewControllerDelegate?
    
    let weatherStackView = UIStackView()
    let temperatureStackView = UIStackView()
    let additionalInfoStackView = UIStackView()
    let oneMoreStackView = UIStackView()
    let cityLabel = UILabel()
    let conditionImageView = UIImageView()
    let temperatureLabel = UILabel()
    let descriptionLabel = UILabel()
    let feelsLikeLabel = UILabel()
    let minTemperatureLabel = UILabel()
    let maxTemperatureLabel = UILabel()
    let windSpeedLabel = UILabel()
    let pressureLabel = UILabel()
    let humidityLabel = UILabel()
    
    var item: City
    
    init (city: City) {
        self.item = city
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupStyle()
        setupLayout()
    
    }
    
}

extension CityWeatherViewController {
    
    func setup() {
                
        title = item.cityName
        cityLabel.text = item.cityName
        conditionImageView.image = UIImage(systemName: item.conditionId ?? "")
        temperatureLabel.text = item.temperature
        descriptionLabel.text = item.dedcription
        
        feelsLikeLabel.text = item.feelsLike
        minTemperatureLabel.text = item.temperatureMin
        maxTemperatureLabel.text = item.temperatureMax
        windSpeedLabel.text = item.windSpeed
        pressureLabel.text = item.pressure
        humidityLabel.text = item.humidity
        
    }
    
    func setupStyle() {
        
        view.backgroundColor = Resources.Colors.background
        navigationItem.largeTitleDisplayMode = .always
        
        weatherStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherStackView.axis = .vertical
        weatherStackView.alignment = .center
        weatherStackView.spacing = 32
        
        temperatureStackView.translatesAutoresizingMaskIntoConstraints = false
        temperatureStackView.axis = .horizontal
        temperatureStackView.alignment = .center
        temperatureStackView.spacing = 16
        
        additionalInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        additionalInfoStackView.axis = .vertical
        additionalInfoStackView.alignment = .center
        additionalInfoStackView.spacing = 8
        
        oneMoreStackView.translatesAutoresizingMaskIntoConstraints = false
        oneMoreStackView.axis = .vertical
        oneMoreStackView.alignment = .center
        oneMoreStackView.spacing = 8
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = .boldSystemFont(ofSize: 36)
        
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.tintColor = .systemBlue
        conditionImageView.contentMode = .scaleAspectFit
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = .boldSystemFont(ofSize: 64)
                
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        
        minTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        minTemperatureLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        
        maxTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTemperatureLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    }

        
    func setupLayout() {
        
        temperatureStackView.addArrangedSubview(temperatureLabel)
        temperatureStackView.addArrangedSubview(conditionImageView)
        
        additionalInfoStackView.addArrangedSubview(windSpeedLabel)
        additionalInfoStackView.addArrangedSubview(pressureLabel)
        additionalInfoStackView.addArrangedSubview(humidityLabel)
        
        oneMoreStackView.addArrangedSubview(feelsLikeLabel)
        oneMoreStackView.addArrangedSubview(minTemperatureLabel)
        oneMoreStackView.addArrangedSubview(maxTemperatureLabel)
        
        weatherStackView.addArrangedSubview(temperatureStackView)
        weatherStackView.addArrangedSubview(descriptionLabel)
        weatherStackView.addArrangedSubview(oneMoreStackView)
        weatherStackView.addArrangedSubview(additionalInfoStackView)
        
        view.addSubview(weatherStackView)
        
        NSLayoutConstraint.activate([
            
            weatherStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            weatherStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: weatherStackView.trailingAnchor, multiplier: 1),
            
            conditionImageView.heightAnchor.constraint(equalToConstant: 80),
            conditionImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}
    



