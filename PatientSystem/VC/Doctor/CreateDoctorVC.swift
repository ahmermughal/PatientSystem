//
//  CreateDoctorVC.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import UIKit

class CreateDoctorVC: UIViewController {
    
    let nameTextField = UITextField()
    let qualTextField = UITextField()

    let button = MyButtonView(text: "Add", frame: CGRect(x: 0, y:0, width: 150, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        layoutUI()
    }
    
    private func configureVC(){
        title = "Add Doctor"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureUI(){
        nameTextField.placeholder = "Name"
        qualTextField.placeholder = "Qualification"
        nameTextField.borderStyle = .roundedRect
        qualTextField.borderStyle = .roundedRect
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let doctor = setupDoctorDetails() else {
            return
        }
        
        NetworkManager.shared.createDoctor(of: doctor) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                if(!response.error){
                    self.displayAlert(title: "Success", message: "Doctor added.")
                }
            case .failure(let erorr):
                print(erorr)
                self.displayAlert(title: "Error", message: "Already exsits")
            }
        }
        
    }
    
    func setupDoctorDetails() -> DoctorModel?{
        
        guard let name = nameTextField.text, !name.isEmpty else {
            displayAlert(title: "Error", message: "Enter name.")
            return nil
        }
        
        guard let qual = qualTextField.text, !qual.isEmpty else {
            displayAlert(title: "Error", message: "Enter Qualification.")
            return nil
        }

        return DoctorModel(name: name, qualification: qual)
    }
    
    
    func layoutUI() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        qualTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        view.addSubview(qualTextField)
        view.addSubview(button)
        NSLayoutConstraint.activate([
        
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),

            qualTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            qualTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            qualTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            qualTextField.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: qualTextField.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    

}
