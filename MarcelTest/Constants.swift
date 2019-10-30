//
//  Constants.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import Foundation
import GoogleMaps

enum MapConstants {
    static let zoomLevel : Float = 15.0
    static let defaultLocation = CLLocation(latitude: 48.85, longitude: 2.34)
}


enum Colors {
    static let favoriteCellColor = UIColor(red: 251/256, green: 251/256, blue: 250/256, alpha: 0.9)
    static let resultsTVColor = UIColor(red: 251/256, green: 251/256, blue: 250/256, alpha: 1)
}

enum Identifiers {
    static let favoriteCellIdentifier = "FavoriteCell"
    static let searchCellIdentifier = "SearchCell"
    static let resultCellIdentifier = "ResultCell"
    static let userLocationCellIdentifier = "UserLocationCell"
    static let toSearch = "toSearch"
    static let toDrive = "toDrive"
}
