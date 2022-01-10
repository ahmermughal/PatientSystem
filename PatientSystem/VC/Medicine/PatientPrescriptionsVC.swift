//
//  PatientPrescriptionsVC.swift
//  PatientSystem
//
//  Created by Ahmer on 24/01/2021.
//

import UIKit

class PatientPrescriptionsVC: UIViewController {

    let patientIDTextField = UITextField()
    let button = MyButtonView(text: "Get", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    var prescriptions : [PrescriptionDetails] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        layoutUI()
        // Do any additional setup after loading the view.
    }
    
    private func configureVC(){
        title = "Prescriptions"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
        
    private func configureUI(){
        patientIDTextField.placeholder = "Patient ID"
        patientIDTextField.borderStyle = .roundedRect
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 200
        tableView.register(PrescriptionTableViewCell.self, forCellReuseIdentifier: PrescriptionTableViewCell.reuseID)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let id = patientIDTextField.text, !id.isEmpty else {
            displayAlert(title: "Error", message: "Enter patient ID.")
            return
        }
        
        NetworkManager.shared.getPrescriptionByID(of: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
            
            case .success(let response):
                print(response)
                DispatchQueue.main.async{
                    self.prescriptions = response.prescriptions
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func layoutUI(){
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        patientIDTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(patientIDTextField)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            
            patientIDTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            patientIDTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            patientIDTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            patientIDTextField.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: patientIDTextField.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PatientPrescriptionsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prescriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PrescriptionTableViewCell.reuseID, for: indexPath) as! PrescriptionTableViewCell
        
        cell.set(pres: prescriptions[indexPath.row])
       
        return cell
    }
    
}
