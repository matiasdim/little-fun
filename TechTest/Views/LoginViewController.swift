//
//  LoginViewController.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 23/10/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var loginVM: LoginViewModel
    
    init(loginVM: LoginViewModel) {
        self.loginVM = loginVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        isModalInPresentation = true
        
        viewModelConfiguration()
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        loginVM.login()
    }
    
    private func viewModelConfiguration() {
        loginVM.validateFields = { [weak self] in
            guard let username = self?.usernameLabel.text,
                  !username.isEmpty,
                  let password = self?.passwordTextField.text,
                  !password.isEmpty else
            {
                return false
            }
            self?.loginVM.setuser(username: username, password: password)            
            return true
        }
        
        loginVM.showError = { [weak self] in
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            self?.showAlert(title: "Login Error", message: "Username and password must not be empty", style: .alert, action: alertAction)
        }
        
        loginVM.dismissVC = { [weak self] in
            self?.dismiss(animated: true)
        }
    }

    private func configure() {
        usernameLabel.text = "Username"
        passwordLabel.text = "Paswsword"
        passwordTextField.isSecureTextEntry = true
        loginButton.setTitle("Login", for: .normal)
    }
    
}
