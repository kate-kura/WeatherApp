//
//  RegisterController.swift
//  WeatherApp
//
//  Created by Екатерина on 11.05.2023.
//

import UIKit

class RegisterController: UIViewController {
    
    private let stackView = UIStackView()
    
    private let headerView = AuthHeaderView(title: "Registration", subTitle: "Create your account")
    private let usernameField = CustomTextField(fieldType: .username)
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    private let signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    
    private let backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupStyle()
        self.setupLayout()
        
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.backButton.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}


extension RegisterController{
    
    private func setupStyle() {
        
        self.view.backgroundColor = Resources.Colors.background
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.contentMode = .center
        self.stackView.axis = .vertical
        self.stackView.spacing = 20
        
        self.backButton.setTitleColor(.systemBlue, for: .normal)
        self.backButton.setTitle("Back", for: .normal)
   
        headerView.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupLayout() {
        
        self.stackView.addArrangedSubview(headerView)
        self.stackView.addArrangedSubview(usernameField)
        self.stackView.addArrangedSubview(emailField)
        self.stackView.addArrangedSubview(passwordField)
        self.stackView.addArrangedSubview(signUpButton)

        self.view.addSubview(stackView)
        self.view.addSubview(backButton)

        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            self.stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.usernameField.heightAnchor.constraint(equalToConstant: 55),
            self.usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

            self.signUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapSignUp() {
        
        let registerUserRequest = RegisterUserRequest(
            username: self.usernameField.text ?? "",
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        
        // Username check
        if !Validator.isValidUsername(for: registerUserRequest.username) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
        // Email check
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            
            let vc = TabBarController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
    }
    
    @objc private func backTapped() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}


