//
//  AddingImportanceView.swift
//  MicrosoftTodo
//
//  Created by linzsc on 16/01/2021.
//

import UIKit

protocol AddingSubViewDelegate {
    func setSelectingDateState()
    func setAddingSubviewState()
    func completeTask()
}

class AddingImportanceSubview: UIView {

    // MARK:- UI
    @IBOutlet weak var taskTextField: UITextField!
    var delegate: AddingSubViewDelegate!
    var task = Task()
    
    // MARK:-  Action
    @IBAction func taskTextFieldDidOnExit(_ sender: Any) {
        taskTextField.resignFirstResponder()
        if taskTextField.text == "" {
            return
        }
        delegate.completeTask()
    }
    
    @IBAction func dateButtonDidTap(_ sender: Any) {
        delegate.setSelectingDateState()
    }

    func makeTask() {
        task.name = taskTextField.text!
        task.isDone = false
        task.isFavourite = true
        task.isMyDay = false
        task.timeCreate = Date.init()
    }
}

extension AddingImportanceSubview: DateSubviewDelegate {
    func doneButtonDidTap(date: Date!) {
        self.delegate.setAddingSubviewState()
        task.date = date
    }
    
    func cancelButtonDidTap() {
        self.delegate.setAddingSubviewState()
    }
    
    
}

