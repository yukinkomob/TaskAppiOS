//
//  Category.swift
//  taskapp
//
//  Created by Mac on 2021/11/19.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var id = 0
    
    @objc dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
