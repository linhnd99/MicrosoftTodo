//
//  Task.swift
//  MicrosoftTodo
//
//  Created by linzsc on 13/01/2021.
//

import UIKit

class Task {
    var id: String?
    var name: String = ""
    var isDone: Bool = false
    var isMyDay: Bool = false
    var timeCreate: Date?
    var isFavourite: Bool = false
    var date: Date?
    
    convenience init(id: String?, name: String, isDone: Bool, isMyDay: Bool, timeCreate: Date?, isFavourite: Bool, date: Date?) {
        self.init()
        self.id = id
        self.name = name
        self.isDone = isDone
        self.isMyDay = isMyDay
        self.timeCreate = timeCreate
        self.isFavourite = isFavourite
        self.date = date
    }
    
}
