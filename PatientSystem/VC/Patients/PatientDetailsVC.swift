//
//  PatientDetailsVC.swift
//  PatientSystem
//
//  Created by Ahmer on 24/01/2021.
//

import UIKit

class PatientDetailsVC: UIViewController {
       
    let patientIDTextField = UITextField()
    let button = MyButtonView(text: "Get", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    
    let patientIDLabel = UILabel()
    let patientID = UILabel()
    let patientNameLabel = UILabel()
    let patientName = UILabel()
    let patientGenderLabel = UILabel()
    let patientGender = UILabel()
    let patientPhoneLabel = UILabel()
    let patientPhone = UILabel()
    let patientAddressLabel = UILabel()
    let patientAddress = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureVC()
        layoutUI()
    }
    
    private func configureVC(){
        title = "Patient Details"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI(){
        
        patientIDLabel.text = "ID:"
        patientNameLabel.text = "Name:"
        patientGenderLabel.text = "Gender:"
        patientPhoneLabel.text = "Phone:"
        patientAddressLabel.text = "Address:"
        patientIDTextField.placeholder = "Patient ID"
        patientIDTextField.borderStyle = .roundedRect
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let id = patientIDTextField.text, !id.isEmpty else {
            displayAlert(title: "Error", message: "Enter patient ID.")
            return
        }
        
        NetworkManager.shared.getPatient(of: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
            
            case .success(let response):
                DispatchQueue.main.async{
                    self.fillData(patient: response)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fillData(patient: PatientModel){
        
        patientID.text = String(patient.pid)
        patientName.text = patient.name
        patientGender.text = patient.sex
        patientPhone.text = patient.phone
        patientAddress.text = patient.address
        
    }
    
    private func layoutUI(){
        
        patientIDTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        patientIDLabel.translatesAutoresizingMaskIntoConstraints = false
        patientNameLabel.translatesAutoresizingMaskIntoConstraints = false
        patientGenderLabel.translatesAutoresizingMaskIntoConstraints = false
        patientPhoneLabel.translatesAutoresizingMaskIntoConstraints = false
        patientAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        patientID.translatesAutoresizingMaskIntoConstraints = false
        patientName.translatesAutoresizingMaskIntoConstraints = false
        patientGender.translatesAutoresizingMaskIntoConstraints = false
        patientPhone.translatesAutoresizingMaskIntoConstraints = false
        patientAddress.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews(patientIDTextField, button, patientIDLabel, patientNameLabel, patientGenderLabel, patientPhoneLabel, patientAddressLabel)
        view.addSubviews(patientID, patientName, patientGender, patientPhone, patientAddress)
        
        let padding : CGFloat = 16
        
        
        NSLayoutConstraint.activate([
            
            patientIDTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            patientIDTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            patientIDTextField.heightAnchor.constraint(equalToConstant: 50),
            patientIDTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: patientIDTextField.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            
            patientIDLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
            patientIDLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            patientIDLabel.widthAnchor.constraint(equalToConstant: 80),
            patientIDLabel.heightAnchor.constraint(equalToConstant: 50),
            
            patientID.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
            patientID.leadingAnchor.constraint(equalTo: patientIDLabel.trailingAnchor, constant: padding),
            patientID.widthAnchor.constraint(equalToConstant: 150),
            patientID.heightAnchor.constraint(equalToConstant: 50),
            
            patientNameLabel.topAnchor.constraint(equalTo: patientIDLabel.bottomAnchor, constant: padding),
            patientNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            patientNameLabel.widthAnchor.constraint(equalToConstant: 80),
            patientNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            patientName.topAnchor.constraint(equalTo: patientIDLabel.bottomAnchor, constant: padding),
            patientName.leadingAnchor.constraint(equalTo: patientNameLabel.trailingAnchor, constant: padding),
            patientName.widthAnchor.constraint(equalToConstant: 150),
            patientName.heightAnchor.constraint(equalToConstant: 50),
            
            patientGenderLabel.topAnchor.constraint(equalTo: patientNameLabel.bottomAnchor, constant: padding),
            patientGenderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            patientGenderLabel.widthAnchor.constraint(equalToConstant: 80),
            patientGenderLabel.heightAnchor.constraint(equalToConstant: 50),
            
            patientGender.topAnchor.constraint(equalTo: patientNameLabel.bottomAnchor, constant: padding),
            patientGender.leadingAnchor.constraint(equalTo: patientGenderLabel.trailingAnchor, constant: padding),
            patientGender.widthAnchor.constraint(equalToConstant: 150),
            patientGender.heightAnchor.constraint(equalToConstant: 50),
            
            patientPhoneLabel.topAnchor.constraint(equalTo: patientGenderLabel.bottomAnchor, constant: padding),
            patientPhoneLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            patientPhoneLabel.widthAnchor.constraint(equalToConstant: 80),
            patientPhoneLabel.heightAnchor.constraint(equalToConstant: 50),
            
            patientPhone.topAnchor.constraint(equalTo: patientGenderLabel.bottomAnchor, constant: padding),
            patientPhone.leadingAnchor.constraint(equalTo: patientPhoneLabel.trailingAnchor, constant: padding),
            patientPhone.widthAnchor.constraint(equalToConstant: 150),
            patientPhone.heightAnchor.constraint(equalToConstant: 50),
            
            patientAddressLabel.topAnchor.constraint(equalTo: patientPhoneLabel.bottomAnchor, constant: padding),
            patientAddressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            patientAddressLabel.widthAnchor.constraint(equalToConstant: 80),
            patientAddressLabel.heightAnchor.constraint(equalToConstant: 50),
            
            patientAddress.topAnchor.constraint(equalTo: patientPhoneLabel.bottomAnchor, constant: padding),
            patientAddress.leadingAnchor.constraint(equalTo: patientAddressLabel.trailingAnchor, constant: padding),
            patientAddress.widthAnchor.constraint(equalToConstant: 150),
            patientAddress.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    
}
