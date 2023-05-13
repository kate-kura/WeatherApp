//
//  ForgotPasswordController.swift
//  WeatherApp
//
//  Created by Екатерина on 11.05.2023.
//

import UIKit

class ForgotPasswordController: UIViewController {
    
    private let stackView = UIStackView()
    
    private let headerView = AuthHeaderView(title: "Forgot Password", subTitle: "Reset your password")
    private let emailField = CustomTextField(fieldType: .email)
    private let resetPasswordButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    
    private let backButton = UIButton()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupLayout()
        
        self.resetPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        self.backButton.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        self.view.backgroundColor = .systemBackground
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.contentMode = .center
        self.stackView.axis = .vertical
        self.stackView.spacing = 20
        
        self.backButton.setTitleColor(.systemBlue, for: .normal)
        self.backButton.setTitle("Back", for: .normal)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupLayout() {
        
        self.stackView.addArrangedSubview(headerView)
        self.stackView.addArrangedSubview(emailField)
        self.stackView.addArrangedSubview(resetPasswordButton)
        
        self.view.addSubview(stackView)
        self.view.addSubview(backButton)

        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            self.stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            self.resetPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapForgotPassword() {
        
        let email = self.emailField.text ?? ""
        
        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
            
            AlertManager.showPasswordResetSent(on: self)
        }
        
    }
    @objc private func backTapped() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

