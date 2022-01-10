//
//  DeleteMedicineVC.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import UIKit

class DeleteMedicineVC: UIViewController {
    
    let medicineIDTextField = UITextField()
    let button = MyButtonView(text: "Delete", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        layoutUI()
    }
    
    private func configureVC(){
        title = "Delete Medicine"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI(){
        medicineIDTextField.placeholder = "Medicine ID"
        medicineIDTextField.borderStyle = .roundedRect
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let id = checkEmptyParameters() else {
            return
        }
        
        NetworkManager.shared.deleteMedicine(of: id) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
            case .success(let response):
                if(!response.error){
                    self.displayAlert(title: "Success", message: "Medicine deleted.")
                }else{
                    self.displayAlert(title: "Error", message: "Medicine does not exist.")
                }
            case .failure(let erorr):
                print(erorr)
                self.displayAlert(title: "Error", message: "Medicine does not exist.")
            }
        }
    }
    
    func checkEmptyParameters() -> String?{
        guard let id = medicineIDTextField.text, !id.isEmpty else {
            displayAlert(title: "Error", message: "Enter medicine ID.")
            return nil
        }
        return id
    }
    
    private func layoutUI(){
        medicineIDTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(medicineIDTextField)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            medicineIDTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            medicineIDTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            medicineIDTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            medicineIDTextField.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: medicineIDTextField.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
}
