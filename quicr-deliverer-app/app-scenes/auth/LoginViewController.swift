//
//  LoginViewController.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 23/10/2020.
//

import UIKit

class LoginViewController : BaseViewController {
    
    var logo = UIComponents.shared.ImageView(imageName: "logo")
    var emailTF = UIComponents.shared.textfield(placeholder: "Email")
    var passwordTF = UIComponents.shared.textfield(placeholder: "Password")
    var loginBtn = UIComponents.shared.button(title: "Login")
    var label = UIComponents.shared.label(text: "The Deliverer App",alignment: .center,fontName: FontName.Bold,fontSize: 18)
    var stackView = UIStackView()
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configStackView()
        setupUI()
        viewModel.delegate = self
    }
    
    private func setupUI() {
        emailTF.autocapitalizationType = .none
        emailTF.keyboardType = .emailAddress
        passwordTF.isSecureTextEntry = true
        loginBtn.addTarget(self, action: #selector(didClickLogin), for: .touchUpInside)
        
        view.addSubViews(views: logo,label,stackView)
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 150),
            logo.heightAnchor.constraint(equalToConstant: 150),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
            
            label.topAnchor.constraint(equalTo: logo.bottomAnchor,constant: -50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: logo.bottomAnchor,constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30)
        ])
    }
    
    private func configStackView() {
        [emailTF,passwordTF,loginBtn].forEach { view in
            stackView.addArrangedSubview(view)
        }
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        NSLayoutConstraint.activate([
            emailTF.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc func didClickLogin() {
        if !isValidData() {
            return
        }
        self.startAnimating()
        viewModel.loginIn(email: emailTF.text!, password: passwordTF.text!)
    }
    
    private func isValidData() -> Bool  {
        if let email = self.emailTF.text {
            if email.isEmpty || !email.isValidEmail() {
                self.alert(message: "Please provide valid email id")
                return false
            }
        }
        if let password = self.passwordTF.text {
            if password.isEmpty  {
                self.alert(message: "Please provide password")
                return false
            }
        }
        return true
    }
}


extension LoginViewController : LoginViewModelDelegate {
    func success() {
    self.stopAnimating()
    let controller = UINavigationController(rootViewController: HomeViewController())
    controller.modalPresentationStyle = .fullScreen
    self.present(controller, animated: true, completion: nil)
    }
    
    func failure(message: String) {
        self.stopAnimating()
        self.alert(message: message)
    }
    
    
}
