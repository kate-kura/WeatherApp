//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Екатерина on 10.01.2023.
//

import Foundation

struct WeatherModel: Codable {

    let conditionId: Int
    let cityName: String
    let temperature: Double
    let dedcription: String

    let feelsLike: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let pressure: Double
    let humidity: Double
    
    let windSpeed: Double

    var temperatureString: String {
        return String(format: "%.0f°C", temperature)
    }

    var feelsLikeString: String {
        return String(format: "feels like   %.0f°C", feelsLike)
    }

    var temperatureMinString: String {
        return String(format: "min temperature   %.0f°C", temperatureMin)
    }

    var temperatureMaxString: String {
        return String(format: "max temperature   %.0f°C", temperatureMax)
    }

    var pressureString: String {
        return String(format: "pressure   %.0fhPa", pressure)
    }

    var humidityString: String {
        return String(format: "humidity level   %.0f%%",  humidity)
    }
    var windSpeedString: String {
        return String(format: "wind speed   %.1fm/s", windSpeed)
    }

    var conditionIcon: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...504:
            return "cloud.sun.rain"
        case 511:
            return "snowflake"
        case 520...531:
            return "cloud.rain"
        case 600...622:
            return "snowflake"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801:
            return "cloud.sun"
        case 802:
            return "cloud"
        case 803...804:
            return "smoke"
        default:
            return "moon"
        }
    }

    var descriprionName: String {
        switch conditionId {
        case 200:
            return "thunderstorm with light rain"
        case 201:
            return "thunderstorm with rain"
        case 202:
            return "thunderstorm with heavy rain"
        case 210:
            return "light thunderstorm"
        case 211:
            return "thunderstorm"
        case 212:
            return "heavy thunderstorm"
        case 221:
            return "ragged thunderstorm"
        case 230:
            return "thunderstorm with light drizzle"
        case 231:
            return "thunderstorm with drizzle"
        case 232:
            return "thunderstorm with heavy drizzle"

        case 300:
            return "light intensity drizzle"
        case 301:
            return "drizzle"
        case 302:
            return "heavy intensity drizzle"
        case 310:
            return "light intensity drizzle rain"
        case 311:
            return "drizzle rain"
        case 312:
            return "heavy intensity drizzle rain"
        case 313:
            return "shower rain and drizzle"
        case 314:
            return "heavy shower rain and drizzle"
        case 321:
            return "shower drizzle"

        case 500:
            return "light rain"
        case 501:
            return "moderate rain"
        case 502:
            return "heavy intensity rain"
        case 503:
            return "very heavy rain"
        case 504:
            return "extreme rain"
        case 511:
            return "freezing rain"
        case 520:
            return "light intensity shower rain"
        case 521:
            return "shower rain"
        case 522:
            return "heavy intensity shower rain"
        case 531:
            return "ragged shower rain"

        case 600:
            return "light snow"
        case 601:
            return "Snow"
        case 602:
            return "Heavy snow"
        case 611:
            return "Sleet"
        case 612:
            return "Light shower sleet"
        case 613:
            return "Shower sleet"
        case 615:
            return "Light rain and snow"
        case 616:
            return "Rain and snow"
        case 620:
            return "Light shower snow"
        case 621:
            return "Shower snow"
        case 622:
            return "Heavy shower snow"

        case 701:
            return "mist"
        case 711:
            return "Smoke"
        case 721:
            return "Haze"
        case 731:
            return "dust whirls"
        case 741:
            return "fog"
        case 751:
            return "sand"
        case 761:
            return "dust"
        case 762:
            return "volcanic ash"
        case 771:
            return "squalls"
        case 781:
            return "tornado"

        case 800:
            return "clear sky"

        case 801:
            return "few clouds"
        case 802:
            return "scattered clouds"
        case 803:
            return "broken clouds"
        case 804:
            return "overcast clouds"

        default:
            return "clear sky"
        }
    }

}
