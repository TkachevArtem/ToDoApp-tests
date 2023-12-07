//
//  TaskTests.swift
//  ToDoAppTDDTests
//
//  Created by Artem Tkachev on 30.10.23.
//

import XCTest
@testable import ToDoAppTDD

final class TaskTests: XCTestCase {

    func testInitTaskWithTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task) // проверяем создается ли такой объект (не нулевой ли он)
        
    }
    
    func testInitTaskWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertNotNil(task)
    }
    
    func testWhenGivenTitleSetsTitle() {
        let task = Task(title: "Foo")
        XCTAssertEqual(task.title, "Foo")
    }
    
    func testWhenGivenDescriptionSetsDescription() {
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertEqual(task.description, "Bar")
    }
    
    func testTaskInitsWithDate() {
        let task = Task(title: "Foo")
        XCTAssertNotNil(task.date)
    }
    
    func testWhenGivenLocationSetsLocation() {
        let location = Location(name: "Foo")
        
        let task = Task(title: "Bar", description: "Baz", location: location)
        XCTAssertEqual(location, task.location)
    }
    
    func testCanBeCreatedFromPlistDictionary() {
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 100)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        
        let locationDict: [String : Any] = ["name" : "Baz"]
        let dictionary: [String : Any] = [ "title" : "Foo", "description" : "Bar", "date" : date, "location" : locationDict]
        let createdTask = Task(dict: dictionary)
        XCTAssertEqual(task, createdTask)
    }
    
    func testCanBeSerializedIntoDictionary() {
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 100)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        
        let generatedTask = Task(dict: task.dictionary)
        XCTAssertEqual(task, generatedTask)
    }

}
