//
//  Resources.swift
//  WeatherApp
//
//  Created by Екатерина on 26.12.2022.
//

import UIKit

enum Resources {
    enum Colors {
        static var blue = UIColor(hexString: "56AFF0")
        static var gray = UIColor(hexString: "929DA5")
        
        static var darkgray = UIColor(hexString: "#545C77")
        
        static var background = UIColor(hexString: "#FFFFFF")
    }
    
    enum Strings {
        enum TabBar {
            static var weather = "Weather"
            static var cities = "Cities"
            static var settings = "Settings"
            
        }
    }
    
    enum Images {
        enum TabBar {
            static var weather = UIImage(systemName: "cloud.sun.fill")
            static var cities = UIImage(systemName: "building.2.fill")
            static var settings = UIImage(systemName: "gearshape.fill")
        }
        enum NavBarButtons {
            static var plus = UIImage(systemName: "plus")
            static var edit = UIImage(systemName: "square.and.pencil")
        }
    }
    
    enum Fonts {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
}
