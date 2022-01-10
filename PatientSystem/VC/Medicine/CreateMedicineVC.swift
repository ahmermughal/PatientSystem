//
//  CreateMedicineVC.swift
//  PatientSystem
//
//  Created by Ahmer on 22/01/2021.
//

import UIKit

class CreateMedicineVC: UIViewController {
    
    let medicineNameTextField = UITextField()
    let quantityTextField = UITextField()
    let saltsTextField = UITextField()
    let priceTextField = UITextField()
    let refundPolicyTextField = UITextField()
    let manufactureIDTextField = UITextField()
    let stackView = UIStackView()
    
    let manDatePicker = UIDatePicker()
    let manDateLabel = UILabel()
    
    let expDatePicker = UIDatePicker()
    let expDateLabel = UILabel()
    
    let medicineTypeTextField = UITextField()
    let medicineTypePicker = UIPickerView()
    var selectedMedicineType = "Tablets"
    let medicineTypeList = ["Tablets", "Capsules", "Syrup", "Injection"]
    
    let button = MyButtonView(text: "Add", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        configureStackView()
        setupMedicineTypePickerView()
        layoutUI()
    }
    
    private func configureVC(){
        title = "Add Medicine"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureUI(){
        medicineNameTextField.placeholder = "Name"
        quantityTextField.placeholder = "Quantity"
        saltsTextField.placeholder = "Salts"
        priceTextField.placeholder = "Price"
        refundPolicyTextField.placeholder = "Refund Policy"
        manufactureIDTextField.placeholder = "Manufacture ID"
        medicineTypeTextField.placeholder = "Medicine Type"

        medicineNameTextField.borderStyle = .roundedRect
        quantityTextField.borderStyle = .roundedRect
        saltsTextField.borderStyle = .roundedRect
        priceTextField.borderStyle = .roundedRect
        refundPolicyTextField.borderStyle = .roundedRect
        manufactureIDTextField.borderStyle = .roundedRect
        medicineTypeTextField.borderStyle = .roundedRect
        
        medicineTypeTextField.text = selectedMedicineType
        
        manDateLabel.text = "Manufacture Date"
        manDateLabel.numberOfLines = 2
        manDatePicker.datePickerMode = .date
        expDatePicker.datePickerMode = .date
        expDateLabel.text = "Expiry Date"
        expDateLabel.numberOfLines = 2
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let medicine = setupMedicineDetails() else {
            return
        }
        
        NetworkManager.shared.createMedicine(of: medicine) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                if(!response.error){
                    self.displayAlert(title: "Success", message: "Medicine added.")
                }
            case .failure(let erorr):
                print(erorr)
                self.displayAlert(title: "Error", message: "Already exsits")
            }
        }
        
    }
    
    
    func setupMedicineDetails() -> MedicineModel?{
        
        guard let name = medicineNameTextField.text, !name.isEmpty else {
            displayAlert(title: "Error", message: "Enter name.")
            return nil
        }
        
        guard let quantity = quantityTextField.text, !quantity.isEmpty else {
            displayAlert(title: "Error", message: "Enter quantity.")
            return nil
        }

        
        guard let salts = saltsTextField.text, !salts.isEmpty else {
            displayAlert(title: "Error", message: "Enter salts in the medicine.")
            return nil
        }
    
        
        guard let price = priceTextField.text, !price.isEmpty else {
            displayAlert(title: "Error", message: "Enter price of medicine.")
            return nil
        }
        
        guard let refundPolicy = refundPolicyTextField.text, !refundPolicy.isEmpty else {
            displayAlert(title: "Error", message: "Enter refund policy of medicine.")
            return nil
        }
        
        guard let manID = manufactureIDTextField.text, !manID.isEmpty else {
            displayAlert(title: "Error", message: "Enter manufacture ID.")
            return nil
        }
        
        let typeID = medicineTypeList.firstIndex(of: medicineTypeTextField.text!)!
        
        let manDate = String(manDatePicker.date.timeIntervalSince1970)
        
        let expDate = String(expDatePicker.date.timeIntervalSince1970)

        return MedicineModel(name: name, quantity: quantity, salts: salts, ManudactureDate: manDate, ExpDate: expDate, price: price, refundPolicy: refundPolicy, manID: manID, typeID: String(typeID + 1))
    }
    
    func configureStackView(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.addArrangedSubview(medicineNameTextField)
        stackView.addArrangedSubview(quantityTextField)
        stackView.addArrangedSubview(saltsTextField)
        stackView.addArrangedSubview(priceTextField)
        stackView.addArrangedSubview(refundPolicyTextField)
        stackView.addArrangedSubview(manufactureIDTextField)
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        manDateLabel.translatesAutoresizingMaskIntoConstraints = false
        manDatePicker.translatesAutoresizingMaskIntoConstraints = false
        expDateLabel.translatesAutoresizingMaskIntoConstraints = false
        expDatePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        view.addSubview(button)
        view.addSubview(manDateLabel)
        view.addSubview(manDatePicker)
        view.addSubview(expDateLabel)
        view.addSubview(expDatePicker)
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            stackView.heightAnchor.constraint(equalToConstant: 340),
            
            manDateLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            manDateLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            manDateLabel.widthAnchor.constraint(equalToConstant: 120),
            manDateLabel.heightAnchor.constraint(equalToConstant: 80),
            
            manDatePicker.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            manDatePicker.leadingAnchor.constraint(equalTo: manDateLabel.trailingAnchor, constant: 8),
            manDatePicker.widthAnchor.constraint(equalToConstant: 180),
            manDatePicker.heightAnchor.constraint(equalToConstant: 50),
            
            
            expDateLabel.topAnchor.constraint(equalTo: manDatePicker.bottomAnchor, constant: 16),
            expDateLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            expDateLabel.widthAnchor.constraint(equalToConstant: 120),
            expDateLabel.heightAnchor.constraint(equalToConstant: 80),
            
            expDatePicker.topAnchor.constraint(equalTo: manDatePicker.bottomAnchor, constant: 16),
            expDatePicker.leadingAnchor.constraint(equalTo: expDateLabel.trailingAnchor, constant: 8),
            expDatePicker.widthAnchor.constraint(equalToConstant: 180),
            expDatePicker.heightAnchor.constraint(equalToConstant: 50),
  
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: expDateLabel.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    
}

extension CreateMedicineVC : UIPickerViewDelegate, UIPickerViewDataSource{
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
