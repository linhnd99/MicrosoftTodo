//
//  MenuTableViewCell.swift
//  MicrosoftTodo
//
//  Created by linzsc on 11/01/2021.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    // MARK:- UI
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberLabel.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
