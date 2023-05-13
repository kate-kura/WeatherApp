//
//  CustomCell.swift
//  WeatherApp
//
//  Created by Екатерина on 19.02.2023.
//

import UIKit

class CustomCell: UITableViewCell {
    
    let conditionImageView = UIImageView()
    let cityLabel = UILabel()
    let descriptionLabel = UILabel()
    var temperatureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
}

extension CustomCell {
    
    func setupStyle() {
        
        conditionImageView.contentMode = .scaleAspectFit
        contentView.addSubview(conditionImageView)
        
        cityLabel.font = UIFont.boldSystemFont(ofSize: 18)
        contentView.addSubview(cityLabel)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(descriptionLabel)
        
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 32)
        contentView.addSubview(temperatureLabel)
    }
    
    func setupLayout() {
        
        conditionImageView.frame = CGRect(x: 10, y: 20, width: 100, height: 60)
        
        cityLabel.frame = CGRect(x: conditionImageView.frame.maxX + 10, y: 20, width: self.frame.width - 230, height: 20)
        
        descriptionLabel.frame = CGRect(x: conditionImageView.frame.maxX + 10, y: cityLabel.frame.maxY + 5, width: self.frame.width - 230, height: 16)
        
        temperatureLabel.frame = CGRect(x: self.frame.width - 100, y: 0, width: 100, height: 100)
        
    }
    
}
