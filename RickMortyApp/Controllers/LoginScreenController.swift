//
//  LoginScreenController.swift
//  RickMortyApp
//
//  Created by Miras Maratov on 13.11.2023.
//

import UIKit

class LoginScreenController: UIViewController {
// MARK: - UIProperties
    private let emailView: UIView = {
        let element = UIView()
        element.backgroundColor = .systemGroupedBackground
        element.layer.cornerRadius = 15
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.systemGray.cgColor
        return element
    }()
    
    private let passwordView: UIView = {
        let element = UIView()
        element.backgroundColor = .systemGroupedBackground
        element.layer.cornerRadius = 15
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.systemGray.cgColor
        return element
    }()
    
    private let emailImgView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "envelope")
        element.contentMode = .scaleToFill
        element.backgroundColor = .clear
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let passwordImgView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "lock")
        element.contentMode = .scaleToFill
        element.backgroundColor = .clear
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("L O G I N", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .deepGreen
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("or Sign Up", for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

// MARK: - properties
    let keychainManager = KeychainManager()
    
// MARK: - life cycyle func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

// MARK: - flow funcs
    func setupUI() {
        view.backgroundColor = .systemBackground
        addViews()
        setConstraints()
    }
    
    private func addViews() {
        view.addSubview(emailView)
        view.addSubview(passwordView)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        emailView.addSubview(emailImgView)
        passwordView.addSubview(passwordImgView)
        emailView.addSubview(emailTextField)
        passwordView.addSubview(passwordTextField)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            emailView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            emailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailView.heightAnchor.constraint(equalToConstant: 60),
            
            passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 20),
            passwordView.heightAnchor.constraint(equalTo: emailView.heightAnchor),
            
            emailImgView.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 10),
            emailImgView.bottomAnchor.constraint(equalTo: emailView.bottomAnchor, constant: -10),
            emailImgView.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 10),
            emailImgView.widthAnchor.constraint(equalTo: emailImgView.heightAnchor),
            
            passwordImgView.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 10),
            passwordImgView.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -10),
            passwordImgView.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 10),
            passwordImgView.widthAnchor.constraint(equalTo: passwordImgView.heightAnchor),
            
            emailTextField.leadingAnchor.constraint(equalTo: emailImgView.trailingAnchor, constant: 10),
            emailTextField.bottomAnchor.constraint(equalTo: emailView.bottomAnchor, constant: -10),
            emailTextField.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -10),
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordImgView.trailingAnchor, constant: 10),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -10),
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -10),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 40),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: 44),
            signupButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc func loginButtonTapped() {
        guard let enteredEmail = emailTextField.text,
              let enteredpassword = passwordTextField.text else {
            return
        }
        
        if keychainManager.isValidCredentials(
            username: enteredEmail,
            password: enteredpassword
        ){
            navigationController?.pushViewController(TabBarController(), animated: true)
        } else {
            print("Errorrrrr")
        }
    }
    
    @objc func signupTapped() {
        guard let email = emailTextField.text,
                let pasword = passwordTextField.text else {
            return
        }
        
        keychainManager.saveCredentials(username: email, password: pasword)
    }
}
