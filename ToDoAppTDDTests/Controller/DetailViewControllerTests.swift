//
//  DetailViewControllerTests.swift
//  ToDoAppTDDTests
//
//  Created by Artem Tkachev on 21.11.23.
//

import XCTest
import CoreLocation
@testable import ToDoAppTDD

final class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testHasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionLabel() {
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
    }
    
    func testHasDateLabel() {
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
    }
    
    func testHasMapView() {
        XCTAssertNotNil(sut.mapView)
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }
    
    func testHasLocationLabel() {
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
    }
    
    func setupTaskAndAppearanceTransition() {
        let coordinate = CLLocationCoordinate2D(latitude: 52.43159837205218, longitude: 30.991410169663528)
        let location = Location(name: "Baz", coordinate: coordinate)
        let date = Date(timeIntervalSince1970: 1700596022)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        sut.task = task
        //view will appear, view did appear
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
    }
    
    func testSettingTaskSetsTitleLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.titleLabel.text, "Foo")
    }
    
    func testSettingTaskSetsDescriptionLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.descriptionLabel.text, "Bar")
    }
    
    func testSettingTaskSetsLocationLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.locationLabel.text, "Baz")
    }
    
    func testSettingTaskSetsDateLabel() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.dateLabel.text, "21.11.23")
    }
    
    func testSettingTaskSetsMapView() {
        setupTaskAndAppearanceTransition()
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, 52.43159837205218, accuracy: 0.01)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, 30.991410169663528, accuracy: 0.01)
    }
    
    
    
}
