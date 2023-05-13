//
//  ButtonCell.swift
//  WeatherApp
//
//  Created by Екатерина on 11.05.2023.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    let logoutButton = UIButton()
    
    func configureButton(with title: String) {
        logoutButton.setTitle("Logout", for: .normal)
    }
}
