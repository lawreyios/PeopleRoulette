//
//  PeopleRouletteViewController.swift
//  PeopleRoulette
//
//  Created by Lawrence Tan on 8/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class PeopleRouletteViewController: UIViewController {
    
    @IBOutlet weak var quantityTextField: UITextField!
    private var pickerView: UIPickerView!
    
    var peopleRouletteViewModel: PeopleRouletteViewModel!
    var viewControllerInjector: ViewControllerInjecting!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        return activityIndicator
    }()
    
    lazy var usersListViewController: UsersListViewController = {
        let viewController = viewControllerInjector.inject(viewController: ViewIdentifier.usersListViewController, in: Storyboard.main) as? UsersListViewController ?? UsersListViewController()
        return viewController
    }()
    
    private var numberOfPeople = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
        getUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
        
        quantityTextField.becomeFirstResponder()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupPickerView() {
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        quantityTextField.inputView = pickerView
        quantityTextField.delegate = self
    }
    
    private func getUsers() {
        showLoadingSpinner()
        peopleRouletteViewModel.getUsers { [weak self] users, errorMessage in
            guard !users.isEmpty else {
                self?.showErrorAlert(with: errorMessage ?? "Error getting users.")
                return
            }
            
            self?.hideLoadingSpinner()
        }
    }
    
    private func showLoadingSpinner() {
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingSpinner() {
        activityIndicator.stopAnimating()
    }
    
    @IBAction func roulette(_ sender: UIButton) {
        usersListViewController.usersListViewModel.setup(with: numberOfPeople)
        navigationController?.pushViewController(usersListViewController, animated: true)
    }
}

extension PeopleRouletteViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return peopleRouletteViewModel.maxCount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(peopleRouletteViewModel.pickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberOfPeople = peopleRouletteViewModel.pickerData[row]
        quantityTextField.text = String(numberOfPeople)
    }
}

extension PeopleRouletteViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension PeopleRouletteViewController {
    func showErrorAlert(with message: String) {
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}

