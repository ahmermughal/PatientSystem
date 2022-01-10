//
//  CreatePatientVC.swift
//  PatientSystem
//
//  Created by Ahmer on 21/01/2021.
//

import UIKit

class CreatePatientVC: UIViewController {
    
    let nameTextField = UITextField()
    let phoneTextField = UITextField()
    let addressTextField = UITextField()
    let genderTextField = UITextField()
    let genderPicker = UIPickerView()
    let stackView = UIStackView()
    let button = MyButtonView(text: "Create", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    
    let genders = ["Male", "Female", "Other"]
    var selectedGender : String = "Male"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        configureStackView()
        setupGenderPickerView()
        layoutUI()
    }
    
    private func configureVC(){
        title = "Create Patient"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureUI(){
        nameTextField.placeholder = "Name"
        phoneTextField.placeholder = "Phone Number"
        addressTextField.placeholder = "Address"
        genderTextField.text = selectedGender
        nameTextField.borderStyle = .roundedRect
        phoneTextField.borderStyle = .roundedRect
        addressTextField.borderStyle = .roundedRect
        genderTextField.borderStyle = .roundedRect
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let patient = setupPatientDetails() else {
            return
        }
        
        NetworkManager.shared.createPatient(of: patient) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                if(!response.error){
                    self.displayAlert(title: "Success", message: "Patient added.")
                }
            case .failure(let erorr):
                print(erorr)
                self.displayAlert(title: "Error", message: "Already exsits")
            }
            
        }
        
    }
    
    
    func setupPatientDetails() -> PatientModel?{
        
        guard let name = nameTextField.text, !name.isEmpty else {
            displayAlert(title: "Error", message: "Enter name.")
            return nil
        }
        
        guard let sex = genderTextField.text, !sex.isEmpty else {
            displayAlert(title: "Error", message: "Enter gender.")
            return nil
        }
        
        guard let phone = phoneTextField.text, !phone.isEmpty else {
            displayAlert(title: "Error", message: "Enter phone number.")
            return nil
        }
        
        guard let address = addressTextField.text, !address.isEmpty else {
            displayAlert(title: "Error", message: "Enter address.")
            return nil
        }
        
        return PatientModel(name: name, sex: sex, phone: phone, address: address)
        
        
    }
    
    func configureStackView(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(phoneTextField)
        stackView.addArrangedSubview(genderTextField)
        stackView.addArrangedSubview(addressTextField)
    }
    
    func setupGenderPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(genderDonePressed))
        toolBar.setItems([doneButton], animated: true)
        //toolBar.tintColor = CenColors.accent
        genderPicker.dataSource = self
        genderPicker.delegate = self
        genderTextField.inputAccessoryView = toolBar
        genderTextField.inputView = genderPicker
    }
    
    @objc func genderDonePressed(){
        self.view.endEditing(true)
        genderTextField.text = selectedGender
    }
    
    func layoutUI(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            stackView.heightAnchor.constraint(equalToConstant: 240),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo:              stackView.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    
}

extension CreatePatientVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = genders[row]
    }
    
}
