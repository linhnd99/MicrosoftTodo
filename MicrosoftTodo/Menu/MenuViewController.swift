//
//  MenuViewController.swift
//  MicrosoftTodo
//
//  Created by linzsc on 11/01/2021.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK:- UI
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    
    // MARK:- define data
    var listMenu = [
        [
            "icon":"star.png",
            "content":"Ngày của tôi",
            "number": -1
        ],
        [
            "icon":"star.png",
            "content":"Quan trọng",
            "number": -1
        ],
        [
            "icon":"star.png",
            "content":"Đã lập kế hoạch",
            "number": -1
        ],
        [
            "icon":"star.png",
            "content":"Đã giao cho bạn",
            "number": -1
        ],
        [
            "icon":"star.png",
            "content":"Task",
            "number": 7
        ]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let nib = UINib(nibName: "MenuTableViewCell", bundle: Bundle.main)
        
        menuTableView.register(nib, forCellReuseIdentifier: "MenuTableViewCellIdentifier")
        menuTableView.rowHeight = 60
        
        menuTableView.reloadData()
        
    }
    

    // MARK:-
    @IBAction func addButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func searchButtonDidTap(_ sender: Any) {
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCellIdentifier", for: indexPath) as! MenuTableViewCell

        cell.iconImageView.image = UIImage.init(named: listMenu[indexPath.row]["icon"] as! String)
        cell.contentLabel.text = (listMenu[indexPath.row]["content"] as! String)
        let number = listMenu[indexPath.row]["number"] as! Int
        if  number >= 0 {
            cell.numberLabel.text = "\(number)"
        }
        else {
            cell.numberLabel.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let myDayVC = MyDayViewController()
            self.navigationController?.pushViewController(myDayVC, animated: true)
        }
        else if indexPath.row == 1 {
            let importanceVC = ImportanceViewController()
            self.navigationController?.pushViewController(importanceVC, animated: true)
        }
    }
    
    
}
