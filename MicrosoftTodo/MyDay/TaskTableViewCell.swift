//
//  TaskTableViewCell.swift
//  MicrosoftTodo
//
//  Created by linzsc on 14/01/2021.
//

import UIKit

protocol TaskTableViewCellDelegate {
    func didSetDone()
}

class TaskTableViewCell: UITableViewCell {
    // MARK:- UI
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    // MARK:- Model
    var task: Task!
    var delegate: TaskTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.containerView.roundView()
        titleLabel.text = task.name
        subtitleLabel.text = "Tasks"
        setDoneButton(isDone: task.isDone)
        setStarButton(isStar: task.isFavourite)
    }
    
    // MARK:- Action
    @IBAction func doneButtonDidTap(_ sender: Any) {
        task?.isDone = !task.isDone
        setDoneButton(isDone: task.isDone)
        
        RealmHelper.taskRLMController.update(task: task)
        delegate.didSetDone()
    }
    @IBAction func starButtonDidTap(_ sender: Any) {
        task?.isFavourite = !task.isFavourite
        setStarButton(isStar: task.isFavourite)
        
        RealmHelper.taskRLMController.update(task: task)
    }
    
    func setDoneButton(isDone: Bool) {
        if isDone {
            doneButton.setBackgroundImage(UIImage(systemName: Icon.CHECK), for: UIControl.State.normal)
            self.titleLabel.attributedText = self.titleLabel.text?.strikeText()
        }
        else {
            doneButton.setBackgroundImage(UIImage(systemName: Icon.UNCHECK), for: UIControl.State.normal)
            self.titleLabel.attributedText = self.titleLabel.text?.normalText()
        }
    }
    func setStarButton(isStar: Bool) {
        if isStar {
            starButton.setBackgroundImage(UIImage(systemName: Icon.STAR), for: UIControl.State.normal)
        }
        else {
            starButton.setBackgroundImage(UIImage(systemName: Icon.UNSTAR), for: UIControl.State.normal)
        }
    }
}
