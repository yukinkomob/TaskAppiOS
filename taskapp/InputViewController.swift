//
//  InputViewController.swift
//  taskapp
//
//  Created by Mac on 2021/11/12.
//

import UIKit
import RealmSwift
import UserNotifications

class InputViewController: UIViewController {
    
    var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let inputViewControllerX: InputViewControllerX = self.children[0] as! InputViewControllerX
        inputViewControllerX.task = task
        
        inputViewControllerX.initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let inputViewControllerX: InputViewControllerX = self.children[0] as! InputViewControllerX
    }
}
