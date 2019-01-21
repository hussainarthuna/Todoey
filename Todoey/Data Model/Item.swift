//
//  Item.swift
//  Todoey
//
//  Created by Hussain Arthuna on 1/21/19.
//  Copyright © 2019 Hussain Arthuna. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
