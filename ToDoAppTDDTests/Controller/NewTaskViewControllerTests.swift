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
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
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
    
    func testGeocoderFetchesCorrectCoordinate() {
        let geocoderAnswer = expectation(description: "Geocoder answer")
        let addressString = "Гомель"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            let placemark = placemarks?.first
            let location = placemark?.location
            
            guard let latitude = location?.coordinate.latitude,
                  let longitude = location?.coordinate.longitude else {
                 XCTFail()
                return
            }
            XCTAssertEqual(latitude, 52.4426006)
            XCTAssertEqual(longitude, 30.9994032)
            geocoderAnswer.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSaveDismissesNewTaskViewController() {
        let mockNewTaskViewController = MockNewTaskViewController()
        let textField = UITextField()
        mockNewTaskViewController.titleTextField = textField
        mockNewTaskViewController.titleTextField.text = "Foo"
        mockNewTaskViewController.descriptionTextField = textField
        mockNewTaskViewController.descriptionTextField.text = "Bar"
        mockNewTaskViewController.locationTextField = textField
        mockNewTaskViewController.locationTextField.text = "Baz"
        mockNewTaskViewController.addressTextField = textField
        mockNewTaskViewController.addressTextField.text = "Гомель"
        mockNewTaskViewController.dateTextField = textField
        mockNewTaskViewController.dateTextField.text = "21.11.23"
        
        mockNewTaskViewController.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            XCTAssertTrue(mockNewTaskViewController.isDismissed)
        }
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
    
    class MockNewTaskViewController: NewTaskViewController {
        var isDismissed = false
        
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            isDismissed = true
        }
        
    }
}
