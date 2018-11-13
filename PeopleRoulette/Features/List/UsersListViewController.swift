//
//  UsersListViewController.swift
//  PeopleRoulette
//
//  Created by Lawrence Tan on 9/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class UsersListViewController: UITableViewController {
    
    var usersListViewModel: UsersListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
        
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // to be implemented
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // to be implemented
        return UITableViewCell()
    }
    
    private func populateUsersListItemCell(with viewModel: UsersListItemRepresenting, at indexPath: IndexPath) -> UsersListItemCell? {
        // to be implemented
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // to be implemented
    }
}
