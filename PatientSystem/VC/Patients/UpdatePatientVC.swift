//
//  UpdatePatientVC.swift
//  PatientSystem
//
//  Created by Ahmer on 22/01/2021.
//

import UIKit

class UpdatePatientVC: UIViewController {

    let patientIDTextField = UITextField()
    let button = MyButtonView(text: "Get Patient", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    
    let phoneTextField = UITextField()
    let addressTextField = UITextField()
    let stackView = UIStackView()
    let updateButton = MyButtonView(text: "Update", frame: CGRect(x: 0, y:0, width: 150, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        configureStackView()
        layoutUI()
    }
    
    private func configureVC(){
        title = "Update Patient"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureUI(){
        patientIDTextField.placeholder = "Patient ID"
        phoneTextField.placeholder = "Phone Number"
        addressTextField.placeholder = "Address"
        patientIDTextField.borderStyle = .roundedRect
        phoneTextField.borderStyle = .roundedRect
        addressTextField.borderStyle = .roundedRect
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
        updateButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(updateButtonTapped)))
    }
    
    
    @objc func updateButtonTapped(){
        
        guard let id = patientIDTextField.text, !id.isEmpty else {
            displayAlert(title: "Error", message: "Enter patient ID.")
            return
        }
        
        guard let phone = phoneTextField.text, !phone.isEmpty else {
            displayAlert(title: "Error", message: "Enter patient phone number.")
            return
        }
        
        guard let address = addressTextField.text, !address.isEmpty else {
            displayAlert(title: "Error", message: "Enter patient address.")
            return
        }
        
        let patient = PatientModel(name: "", sex: "", phone: phone, address: address, pid: Int(id)!)
        
        NetworkManager.shared.updatePatient(of: patient) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                self.displayAlert(title: "Succuess", message: "Patient updated.")
            case .failure(let error):
                self.displayAlert(title: "Error", message: "Error updating patient.")
            }
            
            
        }
        
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
                    self.fillTextFields(patient: response)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fillTextFields(patient: PatientModel){
        phoneTextField.text = patient.phone
        addressTextField.text = patient.address
    }

    
    func configureStackView(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.addArrangedSubview(phoneTextField)
        stackView.addArrangedSubview(addressTextField)
    }
    
    private func layoutUI(){
        patientIDTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(patientIDTextField)
        view.addSubview(button)
        view.addSubview(stackView)
        view.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            patientIDTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            patientIDTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            patientIDTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            patientIDTextField.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: patientIDTextField.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 32),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            updateButton.widthAnchor.constraint(equalToConstant: 150),
            updateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}

