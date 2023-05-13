//
//  RegisterUserRequest.swift
//  WeatherApp
//
//  Created by Екатерина on 11.05.2023.
//

import Foundation

struct RegisterUserRequest: Codable{
    let username: String
    let email: String
    let password: String
}
