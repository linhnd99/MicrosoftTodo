//
//  AddTaskView.swift
//  MicrosoftTodo
//
//  Created by linzsc on 12/01/2021.
//

import UIKit

protocol AddTaskDelegate {
    func completeAddingTask()
    func completeTask(_ task: Task)
    func dateButtonDidTap()
    func showAlert(alert: UIAlertController!)
}

class AddTaskSubview: UIView {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var optionView: UIView!
    var delegate: AddTaskDelegate?
    var pickerSubview: DatePickerSubview?
    
    func initAction() {
        taskTextField.becomeFirstResponder()
        
    }
    
    @IBAction func taskTextFieldDidOnExit(_ sender: Any) {
        taskTextField.resignFirstResponder()
        
        if taskTextField.text == "" {
            let alert = UIAlertController(title: nil, message: "No task name?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            delegate?.showAlert(alert: alert)
            return
        }
        
        let task = Task()
        task.name = taskTextField.text!
        task.timeCreate = Date()
        task.isDone = false
        task.isFavourite = false
        task.isMyDay = true
        
        delegate?.completeTask(task)
    }
    @IBAction func dateButtonDidTap(_ sender: Any) {
        delegate?.dateButtonDidTap()
    }
    
}
