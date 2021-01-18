//
//  ImportanceViewController.swift
//  MicrosoftTodo
//
//  Created by linzsc on 16/01/2021.
//

import UIKit

class ImportanceViewController: UIViewController {
    // MARK:- UI
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var importanceTableView: UITableView!
    @IBOutlet weak var addButtonView: UIView!
    @IBOutlet weak var completeButton: UIButton!
    
    // MARK:- Variables
    var state = StateView.none
    var data: Array<Task> = []
    var addingTaskSubView: AddingImportanceSubview!
    var addingSubviewConstraints = AddingViewConstraint()
    var datePickerSubview: DateSubview!
    var dateSubviewConstraints = AddingViewConstraint()
    var heightKeyboard: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        self.addingTaskSubView.roundView(corners: [.topRight, .topLeft])
    }
    
    // MARK:- Action
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addButtonDidTap(_ sender: Any) {
        self.state = .addingTask
        setState()
    }
    @IBAction func completeButtonDidTap(_ sender: Any) {
        self.completeAddingTask()
    }
    @IBAction func tableViewDidTap(_ sender: Any) {
        self.addingTaskSubView.taskTextField.resignFirstResponder()
    }
    
    func loadData() {
        data = RealmHelper.taskRLMController.getAllInFavourite()
        self.importanceTableView.reloadData()
    }

    func config() {
        
        self.addButtonView.roundView()
        self.addButtonView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        self.datePickerSubview = Bundle.main.loadNibNamed("DateSubview", owner: self, options: nil)?.first as? DateSubview
        self.datePickerSubview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.datePickerSubview!)
        dateSubviewConstraints.leftConstraint = self.datePickerSubview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        dateSubviewConstraints.rightConstraint = self.view.rightAnchor.constraint(equalTo: self.datePickerSubview!.rightAnchor)
        dateSubviewConstraints.bottomConstraint = self.view.bottomAnchor.constraint(equalTo: self.datePickerSubview.bottomAnchor)
        dateSubviewConstraints.heightConstraint = self.datePickerSubview.heightAnchor.constraint(equalToConstant: 0)
        dateSubviewConstraints.active()
        
        
        self.addingTaskSubView = Bundle.main.loadNibNamed("AddingImportanceSubview", owner: self, options: nil)?.first as? AddingImportanceSubview
        self.addingTaskSubView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.addingTaskSubView!)
        self.addingTaskSubView.delegate = self
        self.datePickerSubview.delegate = self.addingTaskSubView
        addingSubviewConstraints.leftConstraint = self.addingTaskSubView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        addingSubviewConstraints.rightConstraint = self.view.rightAnchor.constraint(equalTo: self.addingTaskSubView!.rightAnchor)
        addingSubviewConstraints.bottomConstraint = self.addingTaskSubView.bottomAnchor.constraint(equalTo: self.datePickerSubview.topAnchor)
        addingSubviewConstraints.heightConstraint = self.addingTaskSubView.heightAnchor.constraint(equalToConstant: 0)
        addingSubviewConstraints.active()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        setState()
    }
    
    func setState() {
        if self.state == .addingTask {
            self.completeButton.isHidden = false
            self.optionButton.isHidden = true
            self.addButtonView.isHidden = true
            
            self.addingTaskSubView.isHidden = false
            self.datePickerSubview.isHidden = true
            UIView.animate(withDuration: 0.25, animations: {
                self.addingSubviewConstraints.heightConstraint.constant = 120
                self.addingSubviewConstraints.bottomConstraint.constant = 8
                
                self.dateSubviewConstraints.heightConstraint.constant = 0
                self.dateSubviewConstraints.bottomConstraint.constant = self.heightKeyboard
                self.view.layoutIfNeeded()
            })
        }
        else if self.state == .selectingDatePicker {
            self.completeButton.isHidden = false
            self.optionButton.isHidden = true
            self.addButtonView.isHidden = true
            
            self.addingTaskSubView.isHidden = false
            self.datePickerSubview.isHidden = false
            UIView.animate(withDuration: 0.25, animations: {
                self.addingSubviewConstraints.heightConstraint.constant = 120
                self.addingSubviewConstraints.bottomConstraint.constant = 8
                
                self.dateSubviewConstraints.heightConstraint.constant = 120
                self.dateSubviewConstraints.bottomConstraint.constant = self.heightKeyboard
                
                self.view.layoutIfNeeded()
            })
        }
        else if self.state == .none {
            self.completeButton.isHidden = true
            self.optionButton.isHidden = false
            self.addButtonView.isHidden = false
            
            self.addingTaskSubView.isHidden = true
            self.datePickerSubview.isHidden = true
            UIView.animate(withDuration: 0.25, animations: {
                self.addingSubviewConstraints.heightConstraint.constant = 0
                self.addingSubviewConstraints.bottomConstraint.constant = 0
                
                self.dateSubviewConstraints.heightConstraint.constant = 0
                self.dateSubviewConstraints.bottomConstraint.constant = 0
                
                self.view.layoutIfNeeded()
            })
        }
    }

    @objc func keyboardShow(notification: Notification) {
        let info = notification.userInfo!
        let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        heightKeyboard = keyboardFrame.height
        setState()
    }
    
    @objc func keyboardHide(notification: Notification) {
        heightKeyboard = 0
        setState()
    }
   
    func completeAddingTask() {
        self.addingTaskSubView.makeTask()
        let task = self.addingTaskSubView.task
        
        RealmHelper.taskRLMController.add(task: task)
        
        self.state = .none
        setState()
        self.loadData()
    }
    
    func removeTask(task: Task) {
        let alert = UIAlertController(title: nil, message: "Are you sure?", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {_ in
            RealmHelper.taskRLMController.delete(task: task)
            alert.dismiss(animated: true, completion: nil)
        })
        let noAction = UIAlertAction(title: "No", style: .destructive, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ImportanceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ImportanceTableViewCellIdentifier") as? ImportanceTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("ImportanceTableViewCell", owner: self, options: nil)?.first as? ImportanceTableViewCell
            cell?.accessoryView = .none
        }
        
        cell?.task = data[indexPath.row]
        cell?.delegate = self
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delAction = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "Delete") { (rowAction, indexPath) in
            self.removeTask(task: self.data[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [delAction]
    }
    
}

extension ImportanceViewController: ImportanceTableViewCellDelegate {
    func _reloadData() {
        data = RealmHelper.taskRLMController.getAllInFavourite()
        UIView.animate(withDuration: 0.25, animations: {
            self.importanceTableView.reloadData()
            self.view.layoutIfNeeded()
        })
    }
}

extension ImportanceViewController: AddingSubViewDelegate {
    func completeTask() {
        self.completeAddingTask()
    }

    func setAddingSubviewState() {
        self.state = .addingTask
        self.setState()
    }
    
    func setSelectingDateState() {
        self.state = .selectingDatePicker
        self.setState()
    }
}
