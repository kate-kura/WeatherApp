//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Екатерина on 10.01.2023.
//

import Foundation
import CoreLocation

enum WeatherServiceError: Error {
    case network(statusCode: Int)
    case parsing
    case general(reason: String)
}

protocol WeatherServiceDelegate: AnyObject {
    func didFetchWeather(_ weatherService: WeatherService, _ weather: WeatherModel)
    func didFailWithError(_ weatherService: WeatherService, _ error: WeatherServiceError)
}

struct WeatherService {
    var delegate: WeatherServiceDelegate?
    
    let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?&appid=ba6d9194d7e444532e1acd50e09d6105&units=metric")!
    
    func fetchWeather(cityName: String) {

        guard let urlEncodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            assertionFailure("Could not encode city named: \(cityName)")
            return
        }

        let urlString = "\(weatherURL)&q=\(urlEncodedCityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            guard let unwrapedData = data,
                  let httpResponse = response as? HTTPURLResponse
            else { return }

            guard error == nil else {
                DispatchQueue.main.async {
                    let generalError = WeatherServiceError.general(reason: "Check network availability.")
                    self.delegate?.didFailWithError(self, generalError)
                }
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    self.delegate?.didFailWithError(self, WeatherServiceError.network(statusCode: httpResponse.statusCode))
                }
                return
            }

            guard let weather = self.parseJSON(unwrapedData) else { return }
            
            DispatchQueue.main.async {
                self.delegate?.didFetchWeather(self, weather)
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        guard let decodedData = try? JSONDecoder().decode(WeatherData.self, from: weatherData) else {
            DispatchQueue.main.async {
                self.delegate?.didFailWithError(self, WeatherServiceError.parsing)
            }
            return nil
        }
        
        let id = decodedData.weather[0].id
        let temp = decodedData.main.temp
        let name = decodedData.name
        let desc = decodedData.weather[0].description
        
        let feels = decodedData.main.feels_like
        let tempMin = decodedData.main.temp_min
        let tempMax = decodedData.main.temp_max
        let press = decodedData.main.pressure
        let hum = decodedData.main.humidity
        
        let speed = decodedData.wind.speed
        
        let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, dedcription: desc, feelsLike: feels, temperatureMin: tempMin, temperatureMax: tempMax, pressure: press, humidity: hum, windSpeed: speed)
        
        return weather
    }
}


