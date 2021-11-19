//
//  Task.swift
//  taskapp
//
//  Created by Mac on 2021/11/12.
//

import RealmSwift

class Task: Object {
    @objc dynamic var id = 0
    
    @objc dynamic var title = ""
    
    @objc dynamic var category: Category? = Category()
    
    @objc dynamic var contents = ""
    
    @objc dynamic var date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
