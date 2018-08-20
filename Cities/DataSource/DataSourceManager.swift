//
//  DataSourceManager.swift
//  Cities
//
//  Created by Rafael Nascimento on 19/08/18.
//  Copyright © 2018 Rafael Nascimento. All rights reserved.
//

import Foundation

class DataSourceManager {
    class func parseData(cities: [City]) -> [City] {
        let removablePrefix = ["’", "‘", "'"]
        let replacablePrefix = ["Ð": "D", "Ł": "L", "Ø": "O", "Z̧": "Z", "Ž": "Z", "Ż": "Z", "Æ": "Ae", "Ħ": "H", "Œ": "Oe"]
        return cities.map({ city in
            var newCity = city
            
            // Remove diacritics
            newCity.name = city.name.folding(options: .diacriticInsensitive, locale: .current)
            
            for prefix in removablePrefix {
                if newCity.name.hasPrefix(prefix) {
                    // Remove prefix
                    newCity.name = newCity.name.deletingPrefix(prefix)
                }
            }
            
            for prefix in replacablePrefix {
                if newCity.name.hasPrefix(prefix.key) {
                    // Replace prefix
                    newCity.name = newCity.name.replacingOccurrences(of: prefix.key, with: prefix.value)
                }
            }
            // Capitalize first letter
            newCity.name = newCity.name.capitalizingFirstLetter()
            
            // City to lower case used for optimised search
            newCity.lowercasedName = newCity.name.lowercased()
            return newCity
        })
    }
    
    class func loadDataSource() throws -> [City] {
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONDecoder().decode([City].self, from: data)
                return result
            } catch {
                throw error
            }
        }
        return []
    }
}
