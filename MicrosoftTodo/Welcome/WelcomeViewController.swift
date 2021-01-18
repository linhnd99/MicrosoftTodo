//
//  WelcomeViewController.swift
//  MicrosoftTodo
//
//  Created by linzsc on 11/01/2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK:- UI
    @IBOutlet weak var txtUsername: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        txtUsername.becomeFirstResponder()
        txtUsername.text="admin"
    }

    // MARK:- Action
    @IBAction func txtUsernameDidOnExit(_ sender: Any) {
        if (txtUsername.text == "admin") {
            
            let menuVC = MenuViewController()
            let nav = UINavigationController.init(rootViewController: menuVC)
            UIApplication.shared.windows.first?.rootViewController = nav
        }
        else {
            let alertController = UIAlertController(title: nil, message: "Không tồn tại tài khoản này", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        }
    }
    
    @IBAction func txtUsernameEditingDidEnd(_ sender: Any) {
        
    }
    
    @IBAction func btnRegisterClick(_ sender: Any) {
    }

}
