//
//  BuyMedicineVC.swift
//  PatientSystem
//
//  Created by Ahmer on 22/01/2021.
//

import UIKit

class BuyMedicineVC: UIViewController {

    let medicineIDTextField = UITextField()
    let patientIDTextField = UITextField()
    let quantityTextField = UITextField()
    let stackView = UIStackView()
    let button = MyButtonView(text: "Buy", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureVC()
        configureStackView()
        layoutUI()
    }
    
    private func configureUI(){
        medicineIDTextField.placeholder = "Medicine ID"
        patientIDTextField.placeholder = "Patient ID"
        quantityTextField.placeholder = "Quantity"
        medicineIDTextField.borderStyle = .roundedRect
        patientIDTextField.borderStyle = .roundedRect
        quantityTextField.borderStyle = .roundedRect
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let prescription = setupPrescription() else {
            return
        }
        
        NetworkManager.shared.buyMedicine(of: prescription) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                if(!response.error){
                    self.displayAlert(title: "Success", message: "Purchase Done.")
                }
            case .failure(let erorr):
                print(erorr)
                self.displayAlert(title: "Error", message: "There was some error.")
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
        
        guard let quantity = quantityTextField.text, !quantity.isEmpty else {
            displayAlert(title: "Error", message: "Enter quantity.")
            return nil
        }

        return PrescriptionModel(medID: Int(medID)!, patientID: Int(patientID)!, doctorID: Int("-1")!, quantity: Int(quantity)!, intakeDetails: "", prescriptionDate: "")
    }
    
    func configureStackView(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.addArrangedSubview(medicineIDTextField)
        stackView.addArrangedSubview(patientIDTextField)
        stackView.addArrangedSubview(quantityTextField)
        //stackView.addArrangedSubview(datePicker)
    }
    
    private func configureVC(){
        title = "Buy Medicine"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func layoutUI(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
        
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            stackView.heightAnchor.constraint(equalToConstant: 150),
            
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }

}
