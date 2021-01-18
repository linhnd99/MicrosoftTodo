//
//  RealmHelper.swift
//  MicrosoftTodo
//
//  Created by linzsc on 13/01/2021.
//

import UIKit

class RealmHelper {
    // private variables
    static private var _taskRLMController: TaskRLMController?
    
    // public variables
    static var taskRLMController: TaskRLMController {
        if _taskRLMController == nil {
            _taskRLMController = TaskRLMController()
        }
        return _taskRLMController!
    }
}
