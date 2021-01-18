//
//  RLMTask.swift
//  MicrosoftTodo
//
//  Created by linzsc on 13/01/2021.
//

import UIKit
import RealmSwift

class TaskRLM: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var isMyDay: Bool = false
    @objc dynamic var timeCreate: Date?
    @objc dynamic var isFavourite: Bool = false
    @objc dynamic var date: Date?
    
    override init() {
        self.id = UUID().uuidString
    }
    
    convenience init( name: String, isDone: Bool, isMyDay: Bool, timeCreate: Date, isFavourite: Bool, date: Date) {
        self.init()
        self.id = UUID().uuidString
        self.name = name
        self.isDone = isDone
        self.isMyDay = isMyDay
        self.timeCreate = timeCreate
        self.isFavourite = isFavourite
        self.date = date
    }
    
    func toTask() -> Task {
        return Task(id: self.id, name: self.name, isDone: self.isDone, isMyDay: self.isMyDay, timeCreate: self.timeCreate, isFavourite: self.isFavourite, date: self.date)
    }
    
    static func fromTask(_ task: Task) -> TaskRLM{
        let taskRLM = TaskRLM()
        if task.id != nil {
            taskRLM.id = task.id!
        }
        taskRLM.name = task.name
        taskRLM.isDone = task.isDone
        taskRLM.isMyDay = task.isMyDay
        taskRLM.timeCreate = task.timeCreate
        taskRLM.isFavourite = task.isFavourite
        taskRLM.date = task.date
        return taskRLM
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
