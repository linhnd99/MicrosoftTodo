//
//  TaskRLMController.swift
//  MicrosoftTodo
//
//  Created by linzsc on 13/01/2021.
//

import UIKit
import RealmSwift
class TaskRLMController {
    
    // MARK:- Define
    
    let realm = try! Realm()
    
    
    // MARK:- Action
    func getAll() -> Array<Task> {
        let result = realm.objects(TaskRLM.self)
        
        // convert Array RLM to object
        var data: Array<Task> = []
        for obj in result {
            data.append(obj.toTask())
        }
        return data
    }
    
    func add(task: Task) {
        realm.beginWrite()
        let taskRLM = TaskRLM.fromTask(task)
        realm.add(taskRLM)
        try! realm.commitWrite()
    }
    
    func update(task: Task) {
        let taskRLM = TaskRLM.fromTask(task)
        try! realm.write({
            realm.add(taskRLM, update: .modified)
        })
    }
    
    func delete(task: Task) {
        let taskRLM = TaskRLM.fromTask(task)
        try! realm.write({
            realm.delete(realm.objects(TaskRLM.self).filter("id = %@", taskRLM.id).first! as TaskRLM)
        })
    }
    
    func getAllInMyDay() -> Array<Task> {
        let result = realm.objects(TaskRLM.self).filter("isMyDay = 1")
        var data: Array<Task> = []
        for obj in result {
            data.append(obj.toTask())
        }
        return data
    }
    
    func getAllInFavourite() -> Array<Task> {
        let result = realm.objects(TaskRLM.self).filter("isFavourite = 1")
        var data: Array<Task> = []
        for obj in result {
            data.append(obj.toTask())
        }
        return data
    }
}
