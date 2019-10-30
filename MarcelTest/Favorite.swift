//
//  Favorite.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import Foundation

struct Favorite : Codable {
    var type : String?
    var address : String?
    var lat : Float?
    var long : Float?
}
