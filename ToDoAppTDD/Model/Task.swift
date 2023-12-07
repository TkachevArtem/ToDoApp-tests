//
//  Task.swift
//  ToDoAppTDD
//
//  Created by Artem Tkachev on 30.10.23.
//

import Foundation

struct Task {
    let title: String
    let description: String?
    let date: Date
    let location: Location?
    
    var dictionary: [String : Any] {
        var dict: [String : Any] = [ : ]
        dict["title"] = title
        dict["description"] = description
        dict["date"] = date
        if let location = location {
            dict["location"] = location.dictionary
        }
        return dict
    }
    
    init(title: String, description: String? = nil, date: Date? = nil, location: Location? = nil) {
        self.title = title
        self.description = description
        self.date = date ?? Date()
        self.location = location
    }
}

extension Task {
    init?(dict: [String : Any]) {
        self.title = dict["title"] as! String
        self.description = dict["description"] as? String
        self.date = dict["date"] as? Date ?? Date()
        if let locationDict = dict["location"] as? [String : Any] {
            self.location = Location(dict: locationDict)
        } else {
            self.location = nil
        }
    }
}


extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        if lhs.title == rhs.title,
           lhs.description == rhs.description,
           lhs.location == rhs.location {
            return true
        }
        return false
    }
}
