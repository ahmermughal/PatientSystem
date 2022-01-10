//
//  AlertVC.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import UIKit

class AlertVC: UIViewController {
    
    let containerView = AlertContaninerView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let actionButton = MyButtonView(text: "OK", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    
    var alertTitle: String?
    var message: String?
    
    let padding:CGFloat = 20
    
    init(title: String?, message: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView, titleLabel, actionButton, messageLabel)
        configureContainerView()
        configureTitleLabel()
        configureMessageLabel()
        configureActionButton()
        
        layoutUI()
    }
    
    func layoutUI(){
        
    }
    
    func configureContainerView(){
        NSLayoutConstraint.activate([
                                        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                        containerView.widthAnchor.constraint(equalToConstant: 280),
                                        containerView.heightAnchor.constraint(equalToConstant: 220)])
    }
    
    func configureTitleLabel(){
        titleLabel.text = alertTitle ?? "Something went wrong"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.textAlignment = .center
        NSLayoutConstraint.activate([
                                        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
                                        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                                        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
                                        titleLabel.heightAnchor.constraint(equalToConstant: 28)])
    }
    
    func configureActionButton(){
        actionButton.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissVC)))
        NSLayoutConstraint.activate([
                                        actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
                                        actionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                        actionButton.widthAnchor.constraint(equalToConstant: 150),
                                        actionButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    func configureMessageLabel(){
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 4
        NSLayoutConstraint.activate([
                                        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                                        messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                                        messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
                                        messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)])
    }
    
}
