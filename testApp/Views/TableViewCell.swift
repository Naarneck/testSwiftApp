//
//  TableViewCell.swift
//  testApp
//
//  Created by John Green on 10/2/19.
//  Copyright © 2019 John Green. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!

    func setupCell(title: String, createdAt: String, text: String){
        titleLabel.text = title
        createdAtLabel.text = createdAt
        postLabel.text = text
    }
    
}
