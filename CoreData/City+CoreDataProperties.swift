//
//  City+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Екатерина on 18.04.2023.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var conditionId: String?
    @NSManaged public var dedcription: String?
    @NSManaged public var feelsLike: String?
    @NSManaged public var humidity: String?
    @NSManaged public var pressure: String?
    @NSManaged public var temperature: String?
    @NSManaged public var temperatureMax: String?
    @NSManaged public var temperatureMin: String?
    @NSManaged public var windSpeed: String?

}

extension City : Identifiable {

}
