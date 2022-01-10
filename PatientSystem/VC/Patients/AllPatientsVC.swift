//
//  AllPatientsVC.swift
//  PatientSystem
//
//  Created by Ahmer on 29/01/2021.
//

import UIKit

class AllPatientsVC: UIViewController {

    
    var patients: [PatientModel] = []
    let tableView = UITableView()
    let reuseID = "reuseID"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        layoutUI()
        getAllPatients()
    }
    
    private func getAllPatients(){
        
        NetworkManager.shared.getAllPatient() { [weak self] result in
            guard let self = self else {return}
            switch result {
            
            case .success(let response):
                print(response)
                DispatchQueue.main.async{
                    self.patients = response.patients
                    self.tableView.reloadData()
 
                    //self.fillData(patient: response)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func configureVC(){
        title = "All Patients"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
        
    private func configureUI(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
    }
    
   
    private func layoutUI(){
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension AllPatientsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)

        let patient = patients[indexPath.row]
        cell.textLabel?.text = "\(patient.pid))  \(patient.name)  \(patient.sex)"
        
        //print(date)
        return cell
    }

}
