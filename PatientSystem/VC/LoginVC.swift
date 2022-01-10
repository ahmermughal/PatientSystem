//
//  LoginVC.swift
//  PatientSystem
//
//  Created by Ahmer on 21/01/2021.
//

import UIKit

class LoginVC: UIViewController {

    private let username = "admin"
    private let password = "pass"
    let usernameTextField = UITextField(frame: .zero)
    let passwordTextField = UITextField(frame: .zero)
    let stackView = UIStackView()
    let loginButton = MyButtonView(text: "Login", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    let imageView = UIImageView(image: UIImage(named: "building"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        configureStackView()
        layoutUI()
    }
    
    private func configureVC(){
        title = "Login"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureStackView(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
    }
    
    private func configureUI(){
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        usernameTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        usernameTextField.text = "admin"
        passwordTextField.text = "pass"
        loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginTapped)))
    }
    
    @objc func loginTapped(){
                
        guard usernameTextField.text == username else {return}
        guard passwordTextField.text == password else {return}
        
        pushStartVC()
        
    }
    
    private func pushStartVC(){
        
        let vc = StartVC()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func layoutUI(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        view.addSubview(loginButton)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            imageView.widthAnchor.constraint(equalToConstant: 180),
            
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width - 48),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo:              stackView.bottomAnchor, constant: 16),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.heightAnchor.constraint(equalToConstant: 55)
        
        ])
        
    }

}
