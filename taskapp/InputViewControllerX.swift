//
//  InputViewControllerX.swift
//  taskapp
//
//  Created by Mac on 2021/11/20.
//

import UIKit
import RealmSwift
import UserNotifications

class InputViewControllerX: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    let realm = try! Realm()
    
    var task: Task!
    var categoryArray = try! Realm().objects(Category.self)
    
    var isSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryArray = try! Realm().objects(Category.self)
        categoryPicker.reloadAllComponents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if (isSave) {
            try! realm.write {
                self.task.title = self.titleTextField.text!
                if (categoryArray.count > 0) {
                    self.task.category = categoryArray[self.categoryPicker.selectedRow(inComponent: 0)]
                }
                self.task.contents = self.contentsTextView.text
                self.task.date = self.datePicker.date
                self.realm.add(self.task, update: .modified)
            }
            setNotification(task: self.task)
        }
        super.viewWillDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let inputCategoryViewController:InputCategoryViewController = segue.destination as! InputCategoryViewController
        let category = Category()
        let allCategories = realm.objects(Category.self)
        if allCategories.count != 0 {
            category.id = allCategories.max(ofProperty: "id")! + 1
        }
        inputCategoryViewController.category = category
    }
    
    func initialize() {
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        titleTextField.text = task.title
        if task.category != nil {
            let categoryIndex = self.categoryArray.index(of: task.category!)
            if categoryIndex != nil {
                categoryPicker.selectRow(categoryIndex!, inComponent: 0, animated: false)
            }
        }
        contentsTextView.text = task.contents
        datePicker.date = task.date
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        isSave = true
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let cellLabel = UILabel()
        cellLabel.frame = CGRect(x: 0, y: 0, width: pickerView.rowSize(forComponent: 0).width, height: pickerView.rowSize(forComponent: 0).height)
                cellLabel.textAlignment = .center
                cellLabel.font = UIFont.boldSystemFont(ofSize: 16)
                cellLabel.backgroundColor = UIColor.orange
                cellLabel.textColor = UIColor.white
        
        cellLabel.text = categoryArray[row].name
                
        return cellLabel
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setNotification(task: Task) {
        let content = UNMutableNotificationContent()
        if task.title == "" {
            content.title = "(??????????????????)"
        } else {
            content.title = task.title
        }
        if task.contents == "" {
            content.body = "(????????????)"
        } else {
            content.body = task.contents
        }
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: String(task.id), content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error ?? "???????????????????????? OK")
        }
        
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/---------------")
                print(request)
                print("/---------------")
            }
        }
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
