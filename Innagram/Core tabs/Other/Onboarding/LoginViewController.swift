//
//  LoginViewController.swift
//  Innagram
//
//  Created by YANA on 06/11/2021.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRaduis:CGFloat = 8.0
    }

    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
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
    
    private let loginButton: UIButton = {
        let buttton = UIButton()
        buttton.setTitle("Log in", for: .normal)
        buttton.layer.masksToBounds = true
        buttton.layer.cornerRadius = Constants.cornerRaduis
        buttton.backgroundColor = .systemBlue
        buttton.setTitleColor(.white, for: .normal)
        return buttton
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an Account", for: .normal)
        return button
    }()
    
    private let hearedView:UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "Gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector (didTapLoginButton), for: .touchUpInside)
       createAccountButton.addTarget(self, action: #selector (didCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector (didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector (didTapPrivacyButton), for: .touchUpInside)
        
        
        
        
        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usernameEmailField.delegate = self
        passwordField.delegate = self
        
        hearedView.frame = CGRect(x: 0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.heigth/3.0)
        
       usernameEmailField.frame = CGRect(x: 25,
                                  y: hearedView.bottom + 40,
                                  width: view.width-50,
                                  height:52)
        
      passwordField.frame = CGRect(x: 25,
                                  y: usernameEmailField.bottom + 10,
                                  width: view.width-50,
                                  height:52)
        
       loginButton.frame = CGRect(x: 25,
                                  y: passwordField.bottom + 10,
                                  width: view.width-50,
                                  height:52)
        
        
       createAccountButton.frame = CGRect(x: 25,
                                  y: loginButton.bottom + 10,
                                  width: view.width-50,
                                  height:52)
        
        termsButton.frame = CGRect(x: 10, y: view.heigth - view.safeAreaInsets.bottom-100, width: view.width-20, height: 50)
        
        privacyButton.frame = CGRect(x: 10, y: view.heigth - view.safeAreaInsets.bottom-50, width: view.width-20, height: 50)
        
        configureHeaderView()
    }
    
    private func configureHeaderView(){
        guard hearedView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = hearedView.subviews.first else {
            return
        }
        backgroundView.frame = hearedView.bounds
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        hearedView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0,
                                 y: view.safeAreaInsets.top,
                                 width: hearedView.width,
                                 height: hearedView.heigth - view.safeAreaInsets.top)
    }
    
    private func addSubviews(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(hearedView)
        view.addSubview(createAccountButton)
        
    }
    
    @objc func didTapLoginButton(){ //usertapped login button
        passwordField.resignFirstResponder() // to stop field for waiting for text
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8
        else {
            return
        }
        //login functionality
        var username:String?
        var email:String?
        if usernameEmail.contains("@"), usernameEmail.contains("."){
            //email
            email = usernameEmail
        } else{
            //username
            username = usernameEmail
        }
        
        AuthManager.shared.loginUsed(username: username, email: email, password: password){ success in
            DispatchQueue.main.async { //queue of implementation .main
                if success{
                    //user log in
                    self.dismiss(animated: true, completion: nil)
                } else{
                   // error
                    let alert = UIAlertController(title: "Log in error", message: "We were unable to log you in.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
            
        }
        
    }
    @objc func didTapTermsButton(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else{
            return
        }
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)
    }
    @objc func didTapPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/196883487377501") else{
            return
        }
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)
    }
    @objc func didCreateAccountButton(){
        let vc = RegistrationViewController()
        vc.title = "Create account"
        
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField{
            passwordField.becomeFirstResponder()
        } else if textField == passwordField{
            didTapLoginButton()
        }
        
        return true
    }
}
