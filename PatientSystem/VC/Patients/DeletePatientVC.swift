//
//  DeletePatientVC.swift
//  PatientSystem
//
//  Created by Ahmer on 22/01/2021.
//

import UIKit

class DeletePatientVC: UIViewController {

    let patientIDTextField = UITextField()
    let button = MyButtonView(text: "Delete", frame: CGRect(x: 0, y:0, width: 150, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        layoutUI()
    }
    
    private func configureVC(){
        title = "Delete Patient"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI(){
        patientIDTextField.placeholder = "Patient ID"
        patientIDTextField.borderStyle = .roundedRect
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let id = checkEmptyParameters() else {
            return
        }
        
        NetworkManager.shared.deletePatient(of: id) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                if(!response.error){
                    self.displayAlert(title: "Success", message: "Patient deleted.")
                }
            case .failure(let erorr):
                print(erorr)
                self.displayAlert(title: "Error", message: "Patient does not exist.")
            }
        }
    }
    
    func checkEmptyParameters() -> String?{
        guard let id = patientIDTextField.text, !id.isEmpty else {
            displayAlert(title: "Error", message: "Enter patient ID.")
            return nil
        }
        return id
    }
    
    private func layoutUI(){
        patientIDTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(patientIDTextField)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            patientIDTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            patientIDTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            patientIDTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            patientIDTextField.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: patientIDTextField.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
}
