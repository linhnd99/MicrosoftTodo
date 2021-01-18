//
//  CustomView.swift
//  MicrosoftTodo
//
//  Created by linzsc on 12/01/2021.
//

import UIKit

extension UIView {
    func roundView() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    func roundView(corners: UIRectCorner) {
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        mask.frame = self.bounds
        self.layer.mask = mask
    }
    
}

extension String {
    func strikeText() -> NSAttributedString{
        let attribString = NSMutableAttributedString(string: self)
        attribString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: self.count))
        return attribString
    }
    
    func normalText() -> NSAttributedString{
        let attribString = NSMutableAttributedString(string: self)
        attribString.addAttribute(.strikethroughColor, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: self.count))
        return attribString
    }
}
