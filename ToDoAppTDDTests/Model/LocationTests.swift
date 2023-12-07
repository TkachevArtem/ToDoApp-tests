//
//  LocationTests.swift
//  ToDoAppTDDTests
//
//  Created by Artem Tkachev on 31.10.23.
//

import XCTest
import CoreLocation
@testable import ToDoAppTDD

final class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitSetsName() {
        let location = Location(name: "Foo")
        XCTAssertEqual(location.name, "Foo")
    }

    func testInitSetsCoordinates() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "Foo", coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    func testCanBeCreatedFromPlistDictionary() {
        let location = Location(name: "Foo", coordinate: CLLocationCoordinate2D(latitude: 100.0, longitude: 100.0))
        let dict: [String : Any] = ["name" : "Foo", "latitude" : 100.0, "longitude" : 100.0]
        let createdLocation = Location(dict: dict)
        
        XCTAssertEqual(location, createdLocation)
    }
    
    func testCanBeSerializedIntoDictionary() {
        let location = Location(name: "Foo", coordinate: CLLocationCoordinate2D(latitude: 100.0, longitude: 100.0))
        let generatedLocation = Location(dict: location.dictionary)
        XCTAssertEqual(location, generatedLocation)
    }

}
