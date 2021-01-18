//
//  ImportanceTableViewCell.swift
//  MicrosoftTodo
//
//  Created by linzsc on 16/01/2021.
//

import UIKit

protocol ImportanceTableViewCellDelegate {
    func _reloadData()
}

class ImportanceTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var task: Task!
    var delegate: ImportanceTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.containerView.roundView()
        self.titleLabel.text = task?.name
        self.subtitleLabel.text = "Tasks"
        
    }
    
    // MARK:- Action
    @IBAction func doneButtonDidTap(_ sender: Any) {
        task.isDone = !task.isDone
        
        RealmHelper.taskRLMController.update(task: task)
        
        setState()
    }
    
    @IBAction func starButtonDidTap(_ sender: Any) {
        task.isFavourite = !task.isFavourite
        
        RealmHelper.taskRLMController.update(task: task)
        
        delegate._reloadData()
    }
    
    func setState() {
        if task?.isDone == true {
            self.doneButton.setBackgroundImage(UIImage(named: Icon.CHECK), for: UIControl.State.normal)
        }
        else {
            self.doneButton.setBackgroundImage(UIImage(named: Icon.UNCHECK), for: UIControl.State.normal)
        }
    }
}
