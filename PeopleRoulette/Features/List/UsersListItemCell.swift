//
//  UsersListItemCell.swift
//  PeopleRoulette
//
//  Created by Lawrey on 13/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class UsersListItemCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 8.0
    }
    
    func configure(with name: String, and company: String) {
        nameLabel.text = name
        companyLabel.text = company
    }
    
}
