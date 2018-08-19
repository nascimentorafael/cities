//
//  City.swift
//  Cities
//
//  Created by Rafael Nascimento on 18/08/18.
//  Copyright © 2018 Rafael Nascimento. All rights reserved.
//

import Foundation

struct City: Decodable {
    let _id: Int
    let country: String
    var name: String
    let coord: Coordinate
}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs._id == rhs._id &&
            lhs.country == rhs.country &&
            lhs.name == rhs.name &&
            lhs.coord.lat == rhs.coord.lat &&
            lhs.coord.lon == rhs.coord.lon
    }
}
