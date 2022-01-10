//
//  UpdateMedicineVC.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import UIKit

class UpdateMedicineVC: UIViewController {

    let medicineIDTextField = UITextField()
    let button = MyButtonView(text: "Get Medicine", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    
    
    let medicineNameTextField = UITextField()
    let quantityTextField = UITextField()
    let priceTextField = UITextField()
    let stackView = UIStackView()
    
    let medicineTypeTextField = UITextField()
    let medicineTypePicker = UIPickerView()
    var selectedMedicineType = "Tablets"
    let medicineTypeList = ["Tablets", "Capsules", "Syrup", "Injection"]
    
    let updateButton = MyButtonView(text: "Button", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        configureStackView()
        setupMedicineTypePickerView()
        layoutUI()
    }
    
    private func configureVC(){
        title = "Update Medicine"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureUI(){
        medicineNameTextField.placeholder = "Name"
        quantityTextField.placeholder = "Quantity"
        priceTextField.placeholder = "Price"
        medicineTypeTextField.placeholder = "Medicine Type"
        medicineIDTextField.placeholder = "Medicine ID"
        medicineIDTextField.borderStyle = .roundedRect
        medicineNameTextField.borderStyle = .roundedRect
        quantityTextField.borderStyle = .roundedRect
        priceTextField.borderStyle = .roundedRect
        medicineTypeTextField.borderStyle = .roundedRect
        medicineTypeTextField.text = selectedMedicineType
    }
    
    func configureStackView(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.addArrangedSubview(medicineNameTextField)
        stackView.addArrangedSubview(quantityTextField)
        stackView.addArrangedSubview(priceTextField)
        stackView.addArrangedSubview(medicineTypeTextField)
        
    }
    
    func setupMedicineTypePickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(genderDonePressed))
        toolBar.setItems([doneButton], animated: true)
        medicineTypePicker.dataSource = self
        medicineTypePicker.delegate = self
        medicineTypeTextField.inputAccessoryView = toolBar
        medicineTypeTextField.inputView = medicineTypePicker
    }
    
    @objc func genderDonePressed(){
        self.view.endEditing(true)
        medicineTypeTextField.text = selectedMedicineType
    }
    
    func layoutUI(){
        medicineIDTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(medicineIDTextField)
        view.addSubview(button)
        view.addSubview(stackView)
        view.addSubview(updateButton)

        NSLayoutConstraint.activate([
            
            medicineIDTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            medicineIDTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            medicineIDTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            medicineIDTextField.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: medicineIDTextField.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 32),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            stackView.heightAnchor.constraint(equalToConstant: 240),
            
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            updateButton.widthAnchor.constraint(equalToConstant: 150),
            updateButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    
}

extension UpdateMedicineVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return medicineTypeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return medicineTypeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMedicineType = medicineTypeList[row]
    }

}
