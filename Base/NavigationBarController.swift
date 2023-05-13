//
//  NavigationBarController.swift
//  WeatherApp
//
//  Created by Екатерина on 26.12.2022.
//

import UIKit

final class NavigationBarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        
        navigationBar.prefersLargeTitles = true
        
    }
    
}
