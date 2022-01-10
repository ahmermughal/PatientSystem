//
//  PatientVC.swift
//  PatientSystem
//
//  Created by Ahmer on 21/01/2021.
//

import UIKit

class PatientVC: UIViewController {

    private static let reuseID = "PatientCellID"
    
    let dataList : [OptionsModel] = OptionsModel.getPatientVCData()
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureUI()
        //layoutUI()
    }
    
    private func configureVC(){
        title = "Patient"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI(){
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: PatientVC.reuseID)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }

    func pushCreatePatientVC(){
        let vc = CreatePatientVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushDeletePatientVC(){
        let vc = DeletePatientVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushUpdatePatientVC(){
        let vc = UpdatePatientVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    
    func pushMakeAppointmentVC(){
        let vc = MakeAppointmentVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    func pushCancelAppointmentVC(){
        let vc = CancelAppointmentVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushPatientDetailsVC(){
        let vc = PatientDetailsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushPatientAppointmentsVC(){
        let vc = PatientAppointmentsVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    func pushAllPatientsVC(){
        let vc = AllPatientsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PatientVC : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PatientVC.reuseID)!
        
        cell.textLabel?.text = dataList[indexPath.row].title
        cell.imageView?.image = dataList[indexPath.row].image
        cell.imageView?.tintColor = .black
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0){
            pushCreatePatientVC()
        }else if (indexPath.row == 1){
            pushDeletePatientVC()
        }else if (indexPath.row == 2){
            pushUpdatePatientVC()
        }else if (indexPath.row == 3){
            pushMakeAppointmentVC()
        }else if (indexPath.row == 4){
            pushCancelAppointmentVC()
        }else if (indexPath.row == 5){
            pushPatientDetailsVC()
        }else if(indexPath.row == 6){
            pushPatientAppointmentsVC()
        }else if indexPath.row == 7{
            pushAllPatientsVC()
        }
    }
    
}
