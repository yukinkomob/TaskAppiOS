//
//  TaskTableViewCell.swift
//  taskapp
//
//  Created by Mac on 2021/11/20.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryButton: UIButton!
    
    typealias Handler = (UIButton) -> Void
    private var handler: Handler?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onTouchedCategoryButton(_ sender: Any) {
        handler?(categoryButton)
    }
    
    func setUp(buttonTitle: String?, tapHandler: @escaping Handler) {
        if buttonTitle != nil {
            categoryButton.isHidden = false
            categoryButton.setTitle(buttonTitle, for: .normal)
        } else {
            categoryButton.isHidden = true
        }
        handler = tapHandler
    }
}
