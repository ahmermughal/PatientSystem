//
//  PrescribeMedicineVC.swift
//  PatientSystem
//
//  Created by Ahmer on 24/01/2021.
//

import UIKit

class PrescribeMedicineVC: UIViewController {

    let medicineIDTextField = UITextField()
    let doctorIDTextField = UITextField()
    let patientIDTextField = UITextField()
    let quantityTextField = UITextField()
    let intakeTextField = UITextField()
    let datePicker = UIDatePicker()
    let stackView = UIStackView()
    let appointmentDateLabel = UILabel()
    let button = MyButtonView(text: "Prescribe", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureVC()
        configureStackView()
        layoutUI()
    }
    
    private func configureUI(){
        medicineIDTextField.placeholder = "Medicine ID"
        doctorIDTextField.placeholder = "Doctor ID"
        patientIDTextField.placeholder = "Patient ID"
        quantityTextField.placeholder = "Quantity"
        intakeTextField.placeholder = "Intake Details"
        datePicker.datePickerMode = .date
        medicineIDTextField.borderStyle = .roundedRect
        patientIDTextField.borderStyle = .roundedRect
        doctorIDTextField.borderStyle = .roundedRect
        quantityTextField.borderStyle = .roundedRect
        intakeTextField.borderStyle = .roundedRect
        appointmentDateLabel.text = "Date:"
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let prescription = setupPrescription() else {
            return
        }
        
        NetworkManager.shared.createPrescription(of: prescription) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                if(!response.error){
                    self.displayAlert(title: "Success", message: "Prescriotion made.")
                }
            case .failure(let erorr):
                print(erorr)
                self.displayAlert(title: "Error", message: "Already exsits")
            }
        }
        
    }
    
    
    func setupPrescription() -> PrescriptionModel?{
        
        guard let medID = medicineIDTextField.text, !medID.isEmpty else {
            displayAlert(title: "Error", message: "Enter medicine ID.")
            return nil
        }
        
        guard let patientID = patientIDTextField.text, !patientID.isEmpty else {
            displayAlert(title: "Error", message: "Enter patient ID.")
            return nil
        }

        
        guard let doctorID = doctorIDTextField.text, !doctorID.isEmpty else {
            displayAlert(title: "Error", message: "Enter doctor ID.")
            return nil
        }
        
        guard let quantity = quantityTextField.text, !quantity.isEmpty else {
            displayAlert(title: "Error", message: "Enter quantity.")
            return nil
        }
        
        guard let intakeDetails = intakeTextField.text, !intakeDetails.isEmpty else {
            displayAlert(title: "Error", message: "Enter medicine intake details.")
            return nil
        }
        
                
        let prescriptionDate = String(datePicker.date.timeIntervalSince1970)
        

        return PrescriptionModel(medID: Int(medID)!, patientID: Int(patientID)!, doctorID: Int(doctorID)!, quantity: Int(quantity)!, intakeDetails: intakeDetails, prescriptionDate: prescriptionDate)
    }
    
    func configureStackView(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.addArrangedSubview(medicineIDTextField)
        stackView.addArrangedSubview(patientIDTextField)
        stackView.addArrangedSubview(doctorIDTextField)
        stackView.addArrangedSubview(quantityTextField)
        stackView.addArrangedSubview(intakeTextField)
        //stackView.addArrangedSubview(datePicker)
    }
    
    private func configureVC(){
        title = "Prescribe Medicine"
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
            stackView.heightAnchor.constraint(equalToConstant: 250),
            
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
