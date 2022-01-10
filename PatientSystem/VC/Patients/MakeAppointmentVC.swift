//
//  MakeAppointmentVC.swift
//  PatientSystem
//
//  Created by Ahmer on 22/01/2021.
//

import UIKit

class MakeAppointmentVC: UIViewController {
    
    let patientIDTextField = UITextField()
    let doctorIDTextField = UITextField()
    let datePicker = UIDatePicker()
    let stackView = UIStackView()
    let appointmentDateLabel = UILabel()
    let button = MyButtonView(text: "Make", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureVC()
        configureStackView()
        layoutUI()
    }
    
    private func configureUI(){
        patientIDTextField.placeholder = "Patient ID"
        doctorIDTextField.placeholder = "Doctor ID"
        patientIDTextField.borderStyle = .roundedRect
        doctorIDTextField.borderStyle = .roundedRect
        appointmentDateLabel.text = "Date:"
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let appointment = setupAppointment() else {
            return
        }
        
        NetworkManager.shared.createAppointment(of: appointment) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                if(!response.error){
                    self.displayAlert(title: "Success", message: "Appointment made.")
                    self.assignPatientToDoctor(appointment : appointment)
                }
            case .failure(let erorr):
                print(erorr)
                self.displayAlert(title: "Error", message: "Already exsits")
            }
        }
    }
    
    private func assignPatientToDoctor(appointment : AppointmentModel){
        
        NetworkManager.shared.createAssignedTo(of: appointment) { [weak self] result in
            //guard let self = self else {return}
            
            switch result{
            case .success(let response):
                print(response)
            case .failure(let erorr):
                print(erorr)
               
            }
        }
        
    }
    
    
    func setupAppointment() -> AppointmentModel?{
        
        guard let pID = patientIDTextField.text, !pID.isEmpty else {
            displayAlert(title: "Error", message: "Enter patient ID.")
            return nil
        }
        
        guard let dID = doctorIDTextField.text, !dID.isEmpty else {
            displayAlert(title: "Error", message: "Enter Doctor ID.")
            return nil
        }

        let time = String(datePicker.date.timeIntervalSince1970)

        return AppointmentModel(doctorID: dID, patientID: pID, appointmentDay: time)
    }
    func configureStackView(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.addArrangedSubview(patientIDTextField)
        stackView.addArrangedSubview(doctorIDTextField)
    }
    
    private func configureVC(){
        title = "Make Appointment"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func layoutUI(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        appointmentDateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        view.addSubview(datePicker)
        view.addSubview(button)
        view.addSubview(appointmentDateLabel)
        
        NSLayoutConstraint.activate([
        
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            appointmentDateLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            appointmentDateLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            appointmentDateLabel.widthAnchor.constraint(equalToConstant: 50),
            appointmentDateLabel.heightAnchor.constraint(equalToConstant: 50),
            
            datePicker.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            datePicker.leadingAnchor.constraint(equalTo: appointmentDateLabel.trailingAnchor, constant: 8),
            datePicker.widthAnchor.constraint(equalToConstant: 180),
            datePicker.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
    }


}
