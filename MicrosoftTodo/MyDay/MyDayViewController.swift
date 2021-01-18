//
//  MyDayViewController.swift
//  MicrosoftTodo
//
//  Created by linzsc on 11/01/2021.
//

import UIKit

// MARK:- Enum
enum StateView {
    case none
    case addingTask
    case selectingDatePicker
}

class AddingViewConstraint {
    var leftConstraint: NSLayoutConstraint!
    var rightConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    
    func active() {
        leftConstraint.isActive = true
        rightConstraint.isActive = true
        bottomConstraint.isActive = true
        heightConstraint.isActive = true
    }
    
    func deactive() {
        leftConstraint.isActive = false
        rightConstraint.isActive = false
        bottomConstraint.isActive = false
        heightConstraint.isActive = false
    }
}

class MyDayViewController: UIViewController {
    
    // MARK:- Define
    let HEIGHT_CONSTRAINT_WHEN_APPEAR: CGFloat = 120
    let HEIGHT_CONSTRAINT_WHEN_DISAPPEAR: CGFloat = 50
    
    // MARK:- UI
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var addViewButton: UIView!
    @IBOutlet weak var taskTableView: UITableView!
    
    
    
    
    // MARK:- Variables
    var addTaskSubview: AddTaskSubview!
    var pickerView: DatePickerSubview!
    var data: Array<Task> = []
    var heightKeyboard: CGFloat = 0
    var stateView = StateView.none
    let addTaskSubviewConstraints = AddingViewConstraint()
    let pickerViewConstraints = AddingViewConstraint()
    var dateTask: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        init_()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        
        if self.stateView != StateView.none {
            updateConstraintsWithStateView(param: heightKeyboard)
        }
        
        self.pickerView.roundView(corners: [.topLeft, .topRight])
    }
    
    // MARK:- Init Object
    func init_() {
        data = RealmHelper.taskRLMController.getAllInMyDay()
        self.taskTableView.reloadData()
    }
    
    // MARK:- Config
    func config() {
        configUI()
        
        registerNotification()
    }
    
    fileprivate func configUI() {
        // addViewButton config
        addViewButton.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        addViewButton.roundView()
        
        // datePickerView config
        self.pickerView = Bundle.main.loadNibNamed("DatePickerSubview", owner: self, options: nil)?.first as? DatePickerSubview
        self.view.addSubview(self.pickerView)
        self.pickerView.delegate = self
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        pickerViewConstraints.leftConstraint = self.pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        pickerViewConstraints.rightConstraint = self.pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        pickerViewConstraints.bottomConstraint = self.view.bottomAnchor.constraint(equalTo: self.pickerView.bottomAnchor, constant: 8)
        pickerViewConstraints.heightConstraint = self.pickerView.heightAnchor.constraint(equalToConstant: 0)
        pickerViewConstraints.active()
        
        // addTaskSubview config
        self.addTaskSubview = Bundle.main.loadNibNamed("AddTaskSubview", owner: self, options: nil)?.first as? AddTaskSubview
        self.view.addSubview(addTaskSubview)
        self.addTaskSubview.roundView()
        addTaskSubview.delegate=self
        self.addTaskSubview.translatesAutoresizingMaskIntoConstraints = false
        
        addTaskSubviewConstraints.leftConstraint = self.addTaskSubview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8)
        addTaskSubviewConstraints.rightConstraint = self.addTaskSubview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8)
        addTaskSubviewConstraints.bottomConstraint = self.pickerView.topAnchor.constraint(equalTo: self.addTaskSubview.bottomAnchor, constant: 8)
        addTaskSubviewConstraints.heightConstraint = self.addTaskSubview.heightAnchor.constraint(equalToConstant: 0)
        addTaskSubviewConstraints.active()
        
        self.stateView=StateView.none
        updateConstraintsWithStateView(param: heightKeyboard)
        
        self.completeButton.isHidden = true
    }
    
    fileprivate func registerNotification() {
        // Custom Backend
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShowNotification(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHideNotification(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    fileprivate func updateConstraintsWithStateView(param: CGFloat = 0) {
        if self.stateView == StateView.addingTask {
            addTaskSubviewConstraints.heightConstraint.constant = 120
            pickerViewConstraints.heightConstraint.constant = 0
            pickerViewConstraints.bottomConstraint.constant = param
            addTaskSubviewConstraints.active()
        }
        else if self.stateView == StateView.selectingDatePicker {
            addTaskSubviewConstraints.heightConstraint.constant = 120
            pickerViewConstraints.heightConstraint.constant = 100
            pickerViewConstraints.bottomConstraint.constant = param
            pickerViewConstraints.active()
        }
        else if self.stateView == StateView.none {
            self.addViewButton.isHidden = false
            self.completeButton.isHidden = true
            self.option1Button.isHidden = false
            self.option2Button.isHidden = false
            
            addTaskSubviewConstraints.bottomConstraint.constant = 0
            addTaskSubviewConstraints.heightConstraint.constant = 0
            pickerViewConstraints.bottomConstraint.constant = 0
            pickerViewConstraints.heightConstraint.constant = 0
            
        }
        
        self.view.layoutIfNeeded()
    }
    
    // MARK:- Action
    @IBAction func editButtonDidTap(_ sender: Any) {
        self.taskTableView.setEditing(!self.taskTableView.isEditing, animated: true)
    }
    @IBAction func addButtonDidTap(_ sender: Any) {
        self.addViewButton.isHidden = true
        self.completeButton.isHidden = false
        self.option1Button.isHidden = true
        self.option2Button.isHidden = true
        
        self.addTaskSubview.initAction()
        self.stateView = StateView.addingTask
        updateConstraintsWithStateView(param: heightKeyboard)
    }

    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completeButtonDidTap(_ sender: Any) {
        self.addTaskSubview.taskTextFieldDidOnExit(sender)
    }
    
    @objc func keyboardDidShowNotification(notification: Notification) {
        self.view.layoutIfNeeded()
        let info = notification.userInfo!
        let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let height = keyboardFrame.height
        self.heightKeyboard = height
        
        let time = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        UIView.animate(withDuration: time) {
            self.updateConstraintsWithStateView(param: self.heightKeyboard)
        }
        
    }
    
    @objc func keyboardDidHideNotification(notification: Notification) {
        self.view.layoutIfNeeded()
        let info = notification.userInfo!
        let time = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        heightKeyboard = 0
        
        UIView.animate(withDuration: time) {
            self.updateConstraintsWithStateView(param: self.heightKeyboard)
        }
        
    }
    
    @IBAction func tableViewDidTap(_ sender: Any) {
        addTaskSubview.taskTextField.resignFirstResponder()
        UIView.animate(withDuration: 0.25, animations: {
            self.stateView = StateView.none
            self.view.layoutIfNeeded()
        })
    }
    
}

// MARK:- UITableViewDataSource, UITableViewDelegate
extension MyDayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if data.filter({(task: Task) -> Bool in return task.isDone == true}).count == 0 {
            return 1
        }
        else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return data.filter { (task:Task) -> Bool in
                return task.isDone == false
            }.count
        }
        else if section == 1{
            return data.filter{(task: Task) -> Bool in
                return task.isDone == true
            }.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerSetion = UILabel()
            headerSetion.text = "Đã hoàn thành"
            headerSetion.textColor = .white
            return headerSetion
        }
        return UIView()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCellIdentifier") as? TaskTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("TaskTableViewCell", owner: self, options: nil)?.first as? TaskTableViewCell
            cell?.accessoryView = .none
        }
        
        if indexPath.section == 0 {
            cell!.task = data.filter{(task: Task) -> Bool in return task.isDone == false}[indexPath.row]
        }
        else {
            cell!.task = data.filter{(task: Task) -> Bool in return task.isDone == true}[indexPath.row]
        }
        cell?.delegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delAction = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "Delete", handler: {rowAction,indexPath in
            self.deleteRowAction(indexPath: indexPath)
        })
        return [delAction]
    }
    
    func deleteRowAction(indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: "Are you sure?", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {_ in
            RealmHelper.taskRLMController.delete(task: self.data[indexPath.row])
            self.data.remove(at: indexPath.row)
            self.taskTableView.deleteRows(at: [indexPath], with: .automatic)
        })
        let noAction = UIAlertAction(title: "No", style: .destructive, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print(":)))")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension MyDayViewController: AddTaskDelegate {
    func showAlert(alert: UIAlertController!) {
        self.present(alert, animated: true, completion: nil)
    }
    
    func dateButtonDidTap() {
        self.view.layoutIfNeeded()
        
        self.view.addSubview(pickerView!)
        
        self.stateView = StateView.selectingDatePicker
        self.updateConstraintsWithStateView(param: self.heightKeyboard)
        
        
    }
    
    func completeTask(_ task: Task) {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.stateView = StateView.none
            self.updateConstraintsWithStateView()
            self.view.layoutIfNeeded()
        })
        
        task.date = dateTask
        RealmHelper.taskRLMController.add(task: task)
        data = RealmHelper.taskRLMController.getAll()
        self.taskTableView.reloadData()
        
    }
    
    
    func completeAddingTask() {
        
    }
     
}

extension MyDayViewController: DatePickerSubviewDelegate {
    func cancelButtonDidTap() {
        UIView.animate(withDuration: 0.5, animations:{
            self.stateView = StateView.addingTask
            self.updateConstraintsWithStateView(param: self.heightKeyboard)
            self.view.layoutIfNeeded()
        })
    }
    
    func doneButtonDidTap(date: Date!) {
        UIView.animate(withDuration: 0.5, animations:{
            self.stateView = StateView.addingTask
            self.updateConstraintsWithStateView(param: self.heightKeyboard)
            self.view.layoutIfNeeded()
        })
        dateTask = date
    }
}

extension MyDayViewController: TaskTableViewCellDelegate {
    func didSetDone() {
        self.init_()
    }
    
    
}
