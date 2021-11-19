//
//  InputCategoryViewController.swift
//  taskapp
//
//  Created by Mac on 2021/11/20.
//

import UIKit
import RealmSwift

class InputCategoryViewController: UIViewController {
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    let realm = try! Realm()
    var category: Category!
    
    var isSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if (isSave) {
            try! realm.write {
                self.category.name = self.categoryTextField.text!
                self.realm.add(self.category, update: .modified)
            }
        }
        super.viewWillDisappear(animated)
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        isSave = true
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
