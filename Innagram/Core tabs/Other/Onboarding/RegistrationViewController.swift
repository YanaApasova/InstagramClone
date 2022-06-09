//
//  RegistrationViewController.swift
//  Innagram
//
//  Created by YANA on 06/11/2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRaduis:CGFloat = 8.0
    }
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = Constants.cornerRaduis
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
        
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email adress"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = Constants.cornerRaduis
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
        
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRaduis
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let registerButton: UIButton = {
        let buttton = UIButton()
        buttton.setTitle("Sign up", for: .normal)
        buttton.layer.masksToBounds = true
        buttton.layer.cornerRadius = Constants.cornerRaduis
        buttton.backgroundColor = .systemGreen
        buttton.setTitleColor(.white, for: .normal)
        return buttton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        

        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        usernameField.delegate = self
        passwordField.delegate = self
        
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+10, width: view.width-40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom+10, width: view.width-40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom+10, width: view.width-40, height: 52)
    }
    
    
    @objc private func didTapRegister(){
        passwordField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count>=8,
              let username = usernameField.text, !username.isEmpty else{
                  let ac = UIAlertController(title: "Error", message: "Password should contain atleast 8 characters", preferredStyle: .alert)
                  ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                  present(ac, animated: true)
                  return 
              }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password){
            registered in
            DispatchQueue.main.async {
               
            if registered {
                //procceed
                let vc = HomeViewController()
                self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                self.navigationController?.pushViewController(vc, animated: true)
                    
            } else {
                //failed
                let ac = UIAlertController(title: "Error", message: "Can't register a new user", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            }
        }
    }

    }
}

extension RegistrationViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField{
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            didTapRegister()
        }
        return true
    }
}

