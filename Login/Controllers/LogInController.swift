//
//  LogInController.swift
//  WeatherApp
//
//  Created by Екатерина on 11.05.2023.
//

import UIKit

class LoginViewController: UIViewController {

    private let stackView = UIStackView()
    
    private let headerView = AuthHeaderView(title: "Authorization", subTitle: "Log in to your account")
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    private let logInButton = CustomButton(title: "Log In", hasBackground: true, fontSize: .big)
    private let newUserButton = CustomButton(title: "New User? Create Account.", fontSize: .med)
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupStyle()
        self.setupLayout()
        
        self.logInButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

extension LoginViewController {
    
    private func setupStyle() {
        
        self.view.backgroundColor = Resources.Colors.background
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.contentMode = .center
        self.stackView.axis = .vertical
        self.stackView.spacing = 20
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
    }

    private func setupLayout() {
        self.stackView.addArrangedSubview(headerView)
        self.stackView.addArrangedSubview(emailField)
        self.stackView.addArrangedSubview(passwordField)
        self.stackView.addArrangedSubview(logInButton)
        self.stackView.addArrangedSubview(newUserButton)
        self.stackView.addArrangedSubview(forgotPasswordButton)

        self.view.addSubview(stackView)

        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            self.stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

            self.logInButton.heightAnchor.constraint(equalToConstant: 55),
            self.logInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.newUserButton.heightAnchor.constraint(equalToConstant: 44),
            self.newUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44),
            self.forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapLogIn() {

        let loginRequest = LogInUserRequest(
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        
        // Email check
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.signIn(with: loginRequest) { error in
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
            
            let vc = TabBarController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc private func didTapNewUser() {
        let vc = RegisterController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func didTapForgotPassword() {
        let vc = ForgotPasswordController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

}
