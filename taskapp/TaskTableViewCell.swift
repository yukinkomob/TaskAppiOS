//
//  TaskTableViewCell.swift
//  taskapp
//
//  Created by Mac on 2021/11/20.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
