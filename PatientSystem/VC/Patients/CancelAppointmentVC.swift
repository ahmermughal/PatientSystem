//
//  CancelAppointmentVC.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import UIKit

class CancelAppointmentVC: UIViewController {

    let appointIDTextField = UITextField()
    let button = MyButtonView(text: "Cancel", frame: CGRect(x: 0, y:0, width: 150, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        layoutUI()
    }
    
    private func configureVC(){
        title = "Cancel Appointment"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI(){
        appointIDTextField.placeholder = "Appointment ID"
        appointIDTextField.borderStyle = .roundedRect
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let id = checkEmptyParameters() else {
            return
        }
        
        NetworkManager.shared.cancelAppointment(of: id) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                if(!response.error){
                    self.displayAlert(title: "Success", message: "Appointment cancelled.")
                }else{
                    self.displayAlert(title: "Error", message: "Appointment does not exist.")
                }
            case .failure(let erorr):
                print(erorr)
                self.displayAlert(title: "Error", message: "Appointment does not exist.")
            }
        }
    }
    
    func checkEmptyParameters() -> String?{
        guard let id = appointIDTextField.text, !id.isEmpty else {
            displayAlert(title: "Error", message: "Enter appointment ID.")
            return nil
        }
        return id
    }
    
    private func layoutUI(){
        appointIDTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appointIDTextField)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            appointIDTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appointIDTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appointIDTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            appointIDTextField.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: appointIDTextField.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
}
