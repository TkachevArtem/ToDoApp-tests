//
//  NewTaskViewControllerTests.swift
//  ToDoAppTDDTests
//
//  Created by Artem Tkachev on 22.11.23.
//

import XCTest
import CoreLocation
@testable import ToDoAppTDD

final class NewTaskViewControllerTests: XCTestCase {
    
    var sut: NewTaskViewController!
    var placemark: MockCLPlacemark!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHasTitleTextField() {
        XCTAssertTrue(sut.titleTextField.isDescendant(of: sut.view))
    }
    
    func testHasLocationTextField() {
        XCTAssertTrue(sut.locationTextField.isDescendant(of: sut.view))
    }
    
    func testHasDateTextField() {
        XCTAssertTrue(sut.dateTextField.isDescendant(of: sut.view))
    }
    
    func testHasAddressTextField() {
        XCTAssertTrue(sut.addressTextField.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionTextField() {
        XCTAssertTrue(sut.descriptionTextField.isDescendant(of: sut.view))
    }
    
    func testHasSaveButton() {
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    
    func testHasCancelButton() {
        XCTAssertTrue(sut.cancelButton.isDescendant(of: sut.view))
    }
    
//    func testSaveUsesGeocoderToConvertCoordinateFromAddress() {
//        let df = DateFormatter()
//        df.dateFormat = "dd.MM.yy"
//        let date = df.date(from: "21.11.23")
//        
//        sut.titleTextField.text = "Foo"
//        sut.locationTextField.text = "Bar"
//        sut.dateTextField.text = "21.11.23"
//        sut.addressTextField.text = "Гомель"
//        sut.descriptionTextField.text = "Baz"
//        sut.taskManager = TaskManager()
//        
//        let mockGeocoder = MockCLGeocoder()
//        sut.geocoder = mockGeocoder
//        sut.save()
//        
//        let coordinate = CLLocationCoordinate2D(latitude: 52.4426006, longitude: 30.9994032)
//        let location = Location(name: "Bar", coordinate: coordinate)
//        let generatedTask = Task(title: "Foo", description: "Baz", date: date, location: location)
//        
//        placemark = CLPlacemark(placemark: placemark) as? NewTaskViewControllerTests.MockCLPlacemark
//        placemark.mockCoordinate = coordinate
//        mockGeocoder.completionHandler?([placemark], nil)
//        
//        let task = sut.taskManager.task(at: 0)
//        
//        XCTAssertEqual(task, generatedTask)
//        
//    }
    
    func testSaveButtonHasSaveMethod() {
        let saveButton = sut.saveButton
        guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        XCTAssertTrue(actions.contains("save"))
    }
    
}

extension NewTaskViewControllerTests {
    class MockCLGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockCLPlacemark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D?
        
        override var location: CLLocation? {
            return CLLocation(latitude: mockCoordinate!.latitude, longitude: mockCoordinate!.longitude)
        }
    }
}
