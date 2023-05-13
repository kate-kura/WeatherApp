//
//  TableDataSourceController.swift
//  WeatherApp
//
//  Created by Екатерина on 19.02.2023.
//

import UIKit
import CoreData

protocol TableDataSourceControllerDelegate: AnyObject {
    func didPressDelete(indexPath: IndexPath)
}

class TableDataSourceController: NSObject {
    
    
    weak var delegate: TableDataSourceControllerDelegate?
    
    var data: [City] = []
    
    func getCities() {
        let cityFetch: NSFetchRequest<City> = City.fetchRequest()
        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try managedContext.fetch(cityFetch)
            data = results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        
    }
    
}

// MARK: - UITableViewDataSource
extension TableDataSourceController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: CustomCell.self),
            for: indexPath
        ) as! CustomCell        
        
        let item = data[indexPath.row]

        cell.cityLabel.text = item.cityName
        cell.descriptionLabel.text = item.dedcription
        cell.temperatureLabel.text = item.temperature
        cell.conditionImageView.image = UIImage(systemName: item.conditionId ?? "")
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            AppDelegate.sharedAppDelegate.coreDataStack.managedContext.delete(data[indexPath.row])
            data.remove(at: indexPath.row)
            AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
            
            delegate?.didPressDelete(indexPath: indexPath)
                
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
