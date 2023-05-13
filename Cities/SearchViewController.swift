//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Екатерина on 19.02.2023.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func didPressSave(item: WeatherModel)
}

class SearchViewController: UIViewController {
    
    weak var delegate: SearchViewControllerDelegate?
    
    let dataTextField = UITextField()
    
    var weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        
        weatherService.delegate = self
        dataTextField.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupLayout()
    }
}

extension SearchViewController {
    
    func setupStyle() {
    
        view.backgroundColor = Resources.Colors.background
        
        dataTextField.textAlignment = .center
        dataTextField.font = UIFont.boldSystemFont(ofSize: 18)
        dataTextField.backgroundColor = .systemGray5
        dataTextField.layer.cornerRadius = 8
        dataTextField.placeholder = "Enter city name..."
        dataTextField.becomeFirstResponder()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(save))
        
        
    }
    
    func setupLayout() {
        
        view.addSubview(dataTextField)
        
        dataTextField.frame = CGRect(
            x: (view.bounds.size.width / 2) - 100,
            y: (view.bounds.size.height / 2) ,
            width: view.bounds.size.width - 200,
            height: 40)
    }
    
    
    // MARK: - Selectors
    @objc func save() {
        
        if let city = dataTextField.text {
            weatherService.fetchWeather(cityName: city)
        }
    }
}

// MARK: - WeatherManagerDelegate
extension SearchViewController: WeatherServiceDelegate {

    func didFetchWeather(_ weatherService: WeatherService, _ weather: WeatherModel) {
        
        delegate?.didPressSave(item: weather)
        navigationController?.popViewController(animated: true)
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


extension SearchViewController: UITextFieldDelegate {
    
    @objc func searchPressed(_ sender: UIButton) {
        dataTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dataTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
}
