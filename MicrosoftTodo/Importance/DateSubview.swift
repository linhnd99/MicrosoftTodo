//
//  DateSubview.swift
//  MicrosoftTodo
//
//  Created by linzsc on 16/01/2021.
//

import UIKit

protocol DateSubviewDelegate {
    func doneButtonDidTap(date: Date!)
    func cancelButtonDidTap()
}

class DateSubview: UIView {

    @IBOutlet weak var picker: UIDatePicker!
    var delegate: DateSubviewDelegate!

    @IBAction func doneButtonDidTap(_ sender: Any) {
        delegate.doneButtonDidTap(date: picker.date)
    }
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        delegate.cancelButtonDidTap()
    }
}
