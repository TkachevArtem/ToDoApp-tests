//
//  Location.swift
//  ToDoAppTDD
//
//  Created by Artem Tkachev on 31.10.23.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    var dictionary: [String : Any] {
        var dict: [String : Any] = [ : ]
        dict["name"] = name
        if let coordinate = coordinate {
            dict["latitude"] = coordinate.latitude
            dict["longitude"] = coordinate.longitude
        }
        return dict
    }
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}

extension Location {
    init?(dict: [String : Any]) {
        self.name = dict["name"] as! String
        if let latitude = dict["latitude"] as? Double,
           let longitude = dict["longitude"] as? Double {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = nil
        }
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        guard lhs.coordinate?.latitude == rhs.coordinate?.latitude && lhs.coordinate?.longitude == rhs.coordinate?.longitude && lhs.name == rhs.name else { return false }
        return true
    }
}
