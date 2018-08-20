//
//  CitiesTests.swift
//  CitiesTests
//
//  Created by Rafael Nascimento on 18/08/18.
//  Copyright © 2018 Rafael Nascimento. All rights reserved.
//

import XCTest
@testable import Cities

class CitiesTests: XCTestCase {
    var cityList: CityListViewController?
    
    override func setUp() {
        super.setUp()
        cityList = CityListViewController()
        cityList?.loadDataSource()
    }
    
    override func tearDown() {
        cityList = nil
        super.tearDown()
    }
    
    func testSearchResultCountForAmsterdam() {
        let result1: [City] = (cityList?.search(searchText: "Amsterdam".lowercased()))!
        XCTAssert(result1.count == 4)
    }
    
    func testSearchResultCountForBudapest() {
        let result1: [City] = (cityList?.search(searchText: "Budapest".lowercased()))!
        XCTAssert(result1.count == 24)
    }
    
    func testSearchResultValuesForAracaju() {
        let aracajuCoord = Coordinate(lat: -10.91111, lon: -37.071671)
        let aracajuCity = City(_id: 3471872, country: "BR", name: "Aracaju", lowercasedName: "aracaju", coord: aracajuCoord)
        
        let result2: [City] = (cityList?.search(searchText: "Aracaju".lowercased()))!
        XCTAssert(result2 == [aracajuCity])
    }
    
    func testSearchResultValuesForAlaba() {
        let alabaCoord1 = Coordinate(lat: 32.750408, lon: -86.750259)
        let alabaCity1 = City(_id: 4829764, country: "US", name: "Alabama", lowercasedName: "alabama", coord: alabaCoord1)
        
        let alabaCoord2 = Coordinate(lat: 33.244282, lon: -86.816383)
        let alabaCity2 = City(_id: 4829762, country: "US", name: "Alabaster", lowercasedName: "alabaster", coord: alabaCoord2)
        
        let alabaCoord3 = Coordinate(lat: 14.10278, lon: 122.015282)
        let alabaCity3 = City(_id: 1731749, country: "PH", name: "Alabat", lowercasedName: "alabat", coord: alabaCoord3)
        
        let alabaCoord4 = Coordinate(lat: 45.26667, lon: 34.133331)
        let alabaCity4 = City(_id: 713724, country: "UA", name: "Alabash Konrat", lowercasedName: "alabash konrat", coord: alabaCoord4)
        
        let result2: [City] = (cityList?.search(searchText: "Alaba".lowercased()))!
        XCTAssert(result2 == [alabaCity1, alabaCity2, alabaCity3, alabaCity4].sorted(by: { $0.name < $1.name }))
    }
}
