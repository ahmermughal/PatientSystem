//
//  UpdateDoctorVC.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import UIKit

class UpdateDoctorVC: UIViewController {
    
    let doctorIDTextField = UITextField()
    let button = MyButtonView(text: "Get Doctor", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    
    let qualTextField = UITextField()
    
    let updateButton = MyButtonView(text: "Update", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        layoutUI()
    }
    
    private func configureVC(){
        title = "Update Doctor"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureUI(){
        qualTextField.placeholder = "Qualification"
        doctorIDTextField.placeholder = "Doctor ID"
        qualTextField.borderStyle = .roundedRect
        doctorIDTextField.borderStyle = .roundedRect
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
        updateButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(updateButtonTapped)))
    }
    
    
    @objc func updateButtonTapped(){
        
        guard let id = doctorIDTextField.text, !id.isEmpty else {
            displayAlert(title: "Error", message: "Enter doctor ID.")
            return
        }
        
        guard let qualification = qualTextField.text, !qualification.isEmpty else {
            displayAlert(title: "Error", message: "Enter doctor qualification.")
            return
        }
        
        
        let doctor = DoctorModel(name: "", qualification: qualification, dID: Int(id)!)
        
        NetworkManager.shared.updateDoctor(of: doctor) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success( _):
                self.displayAlert(title: "Succuess", message: "Doctor updated.")
            case .failure( _):
                self.displayAlert(title: "Error", message: "Error updating patient.")
            }
            
            
        }
        
    }
    
    @objc func buttonTapped(){
        
        guard let id = doctorIDTextField.text, !id.isEmpty else {
            displayAlert(title: "Error", message: "Enter doctor ID.")
            return
        }
        
        NetworkManager.shared.getDoctor(of: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
            
            case .success(let response):
                DispatchQueue.main.async{
                    self.fillTextFields(doctor: response)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fillTextFields(doctor: DoctorModel){
        qualTextField.text = doctor.qualification
    }

    
    func layoutUI(){
        qualTextField.translatesAutoresizingMaskIntoConstraints = false
        doctorIDTextField.translatesAutoresizingMaskIntoConstraints = false
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(qualTextField)
        view.addSubview(doctorIDTextField)
        view.addSubview(updateButton)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            
            doctorIDTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doctorIDTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            doctorIDTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            doctorIDTextField.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: doctorIDTextField.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            qualTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qualTextField.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 32),
            qualTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            qualTextField.heightAnchor.constraint(equalToConstant: 50),
            
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.topAnchor.constraint(equalTo: qualTextField.bottomAnchor, constant: 16),
            updateButton.widthAnchor.constraint(equalToConstant: 150),
            updateButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    
    
}
