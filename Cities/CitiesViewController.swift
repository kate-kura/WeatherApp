//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Екатерина on 26.12.2022.
//

import UIKit

class CitiesViewController: UIViewController, TableDataSourceControllerDelegate {
    func didPressDelete(indexPath: IndexPath) {
        return
    }
    
    let tableViewDataSource = TableDataSourceController()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setupTableViewDataSource()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupLayout()
        
    }

}

extension CitiesViewController {
    
    func setupView() {
        
        view.backgroundColor = Resources.Colors.background
        title = "Weather"
        navigationController?.tabBarItem.title = Resources.Strings.TabBar.cities
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showSearchScreen))
        
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = tableViewDataSource
        tableView.register(
            CustomCell.self,
            forCellReuseIdentifier: String(describing: CustomCell.self)
        )
        tableView.tableFooterView = UIView()
        
    }
    
    func setupTableViewDataSource() {
        tableViewDataSource.getCities()
        tableViewDataSource.delegate = self
    }
    
    func setupLayout() {
        
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    // MARK: - Selectors
    @objc func showSearchScreen() {
        
        let vc = SearchViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}


// MARK: - UITableViewDelegate
extension CitiesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = CityWeatherViewController(city: tableViewDataSource.data[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK: - SearchViewControllerDelegate
extension CitiesViewController: SearchViewControllerDelegate {
    
    func didPressSave(item: WeatherModel) {
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let newCity = City(context: managedContext)
        newCity.setValue(item.cityName, forKey: #keyPath(City.cityName))
        newCity.setValue(item.descriprionName, forKey: #keyPath(City.dedcription))
        newCity.setValue(item.temperatureString, forKey: #keyPath(City.temperature))
        newCity.setValue(item.conditionIcon, forKey: #keyPath(City.conditionId))
        newCity.setValue(item.feelsLikeString, forKey: #keyPath(City.feelsLike))
        newCity.setValue(item.temperatureMinString, forKey: #keyPath(City.temperatureMin))
        newCity.setValue(item.temperatureMaxString, forKey: #keyPath(City.temperatureMax))
        newCity.setValue(item.windSpeedString, forKey: #keyPath(City.windSpeed))
        newCity.setValue(item.pressureString, forKey: #keyPath(City.pressure))
        newCity.setValue(item.humidityString, forKey: #keyPath(City.humidity))
        self.tableViewDataSource.data.insert(newCity, at: 0)
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext() // Save changes in CoreData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
