//
//  TabBarController.swift
//  WeatherApp
//
//  Created by Екатерина on 26.12.2022.
//

import UIKit

enum Tabs: Int {
    case weather
    case cities
    case settings
}

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tabBar.tintColor = Resources.Colors.blue
        tabBar.barTintColor = Resources.Colors.gray
        tabBar.backgroundColor = .white
        
        let weatherController = WeatherViewController()
        let citiesController = CitiesViewController()
        let settingsController = SettingsViewController()
        
        let weatherNavigationController = NavigationBarController(rootViewController: weatherController)
        let citiesNavigationController = NavigationBarController(rootViewController: citiesController)
        let settingsNavigationController = NavigationBarController(rootViewController: settingsController)
        
        weatherNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.weather,
                                                              image: Resources.Images.TabBar.weather,
                                                              tag: Tabs.weather.rawValue)
        citiesNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.cities,
                                                             image: Resources.Images.TabBar.cities,
                                                             tag: Tabs.cities.rawValue)
        settingsNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.settings,
                                                               image: Resources.Images.TabBar.settings,
                                                               tag: Tabs.settings.rawValue)
        
        setViewControllers([weatherNavigationController,
                           citiesNavigationController,
                           settingsNavigationController], animated: false)
    }
}
