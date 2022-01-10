//
//  PatientAppointmentsVC.swift
//  PatientSystem
//
//  Created by Ahmer on 24/01/2021.
//

import UIKit

class PatientAppointmentsVC: UIViewController {

    let patientIDTextField = UITextField()
    let button = MyButtonView(text: "Get", frame: CGRect(x: 0, y:0, width: 150, height: 50))
    var appointments: [AppointmentDetails] = []
    let tableView = UITableView()
    static let cellReuseID = "tableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        layoutUI()
        // Do any additional setup after loading the view.
    }
    
    private func configureVC(){
        title = "Appointments"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
        
    private func configureUI(){
        patientIDTextField.placeholder = "Patient ID"
        patientIDTextField.borderStyle = .roundedRect
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: PatientAppointmentsVC.cellReuseID)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
    }
    
    @objc func buttonTapped(){
        
        guard let id = patientIDTextField.text, !id.isEmpty else {
            displayAlert(title: "Error", message: "Enter patient ID.")
            return
        }
        
        NetworkManager.shared.getAppointmentsByID(of: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
            
            case .success(let response):
                print(response)
                DispatchQueue.main.async{
                    self.appointments = response.appointments
                    self.tableView.reloadData()
                    if !self.appointments.isEmpty{
                        self.title = "\(self.appointments[0].patientName) Appointments"
                    }
                    //self.fillData(patient: response)
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

extension PatientAppointmentsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PatientAppointmentsVC.cellReuseID, for: indexPath)
        let timeIntervel = TimeInterval(appointments[indexPath.row].appointmentDate)
        let date = Date(timeIntervalSince1970: timeIntervel!)
        let doctorName = appointments[indexPath.row].doctorName
        cell.textLabel?.text = "\(date.formattedDateString()) at \(date.formattedTimeString()) with \(doctorName)"

        //print(date)
        return cell
    }
    
    
    
    
}
