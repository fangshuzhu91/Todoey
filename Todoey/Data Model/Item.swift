//
//  Item.swift
//  Todoey
//
//  Created by Ruth Lycke on 4/23/19.
//  Copyright © 2019 tcmrestoration. All rights reserved.
//

import Foundation
//class Item : Encodable, Decodable {
    class Item : Codable {
    var title : String = ""
    var done : Bool = false
}
