//
//  DatePickerSubview.swift
//  MicrosoftTodo
//
//  Created by linzsc on 14/01/2021.
//

import UIKit

protocol DatePickerSubviewDelegate {
    func cancelButtonDidTap()
    func doneButtonDidTap(date: Date!)
}

class DatePickerSubview: UIView {

    @IBOutlet weak var datePicker: UIDatePicker!
    var delegate: DatePickerSubviewDelegate?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func doneButtonDidTap(_ sender: Any) {
        delegate?.doneButtonDidTap(date: datePicker.date)
    }
    
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        delegate?.cancelButtonDidTap()
    }
}
