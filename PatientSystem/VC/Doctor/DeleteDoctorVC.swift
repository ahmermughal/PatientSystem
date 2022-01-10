//
//  DeleteDoctorVC.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import UIKit

class DeleteDoctorVC: UIViewController {
    
    let doctorIDTextField = UITextField()
    let button = MyButtonView(text: "Delete", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        layoutUI()
    }
    
    private func configureVC(){
        title = "Delete Doctor"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI(){
        doctorIDTextField.placeholder = "Doctor ID"
        doctorIDTextField.borderStyle = .roundedRect
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let id = checkEmptyParameters() else {
            return
        }
        
        NetworkManager.shared.deleteDoctor(of: id) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                if(!response.error){
                    self.displayAlert(title: "Success", message: "Doctor deleted.")
                }else{
                    self.displayAlert(title: "Error", message: "Doctor does not exist.")
                }
            case .failure(let erorr):
                print(erorr)
                self.displayAlert(title: "Error", message: "Doctor does not exist.")
            }
        }
    }
    
    func checkEmptyParameters() -> String?{
        guard let id = doctorIDTextField.text, !id.isEmpty else {
            displayAlert(title: "Error", message: "Enter doctor ID.")
            return nil
        }
        return id
    }
    private func layoutUI(){
        doctorIDTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doctorIDTextField)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            doctorIDTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doctorIDTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            doctorIDTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            doctorIDTextField.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: doctorIDTextField.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
}
