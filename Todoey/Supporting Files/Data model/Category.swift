//
//  Category.swift
//  Todoey
//
//  Created by Ruth Lycke on 4/25/19.
//  Copyright © 2019 tcmrestoration. All rights reserved.
//

import Foundation
import RealmSwift
class Category: Object {
    
    @objc dynamic var name: String = ""
    
    let items = List<Item>()
    
    
}
