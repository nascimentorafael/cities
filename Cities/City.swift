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
    let name: String
    let coord: Coordinate
}
