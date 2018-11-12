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
    var viewControllerInjector: ViewControllerInjecting!
    
    lazy var userDetailsViewController: UserDetailsViewController = {
        let viewController = viewControllerInjector.inject(viewController: ViewIdentifier.userDetailsViewController, in: Storyboard.main) as? UserDetailsViewController ?? UserDetailsViewController()
        return viewController
    }()
    
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
        return usersListViewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = usersListViewModel.getUser(for: indexPath.row)
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.company?.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = usersListViewModel.getUser(for: indexPath.row)
        userDetailsViewController.userDetailsViewModel.setupUserInfo(user)
        navigationController?.pushViewController(userDetailsViewController, animated: true)
    }
}
