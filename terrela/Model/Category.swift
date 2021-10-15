//
//  Category.swift
//  terrela
//
//  Created by Eric Morales on 7/14/21.
//

import Foundation

enum Category: String, CaseIterable {
    case rockets = "rockets"
    case missions = "missions"
    case astronomicalObjects = "astronomical objects"
    case pictureOfTheDay = "picture of the day"
    
    func displayName() -> String {
        switch self {
        case .pictureOfTheDay:
            return "Picture of the Day"
        default:
            return self.rawValue.capitalized
        }
    }
}

enum imageName: String, CaseIterable {
    case rockets = "flame"
    case missions = "list.dash"
    case astronomicalObjects = "sun.max"
    case pictureOfTheDay = "circle.grid.hex"
}
