//
//  UserDetailsViewController.swift
//  PeopleRoulette
//
//  Created by Lawrence Tan on 8/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var userDetailsLabel: UILabel!
        
    var userDetailsViewModel: UserDetailsViewModel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUserInfo()
    }
    
    private func setupUserInfo() {
        userDetailsLabel.text = userDetailsViewModel.userInfo
    }

}
