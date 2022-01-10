//
//  StartVC.swift
//  PatientSystem
//
//  Created by Ahmer on 21/01/2021.
//

import UIKit

class StartVC: UIViewController {

    private static let reuseID = "StartCellID"
    
    let startDataList : [OptionsModel] = OptionsModel.getStartVCData()
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureUI()
        //layoutUI()
    }
    
    private func configureVC(){
        title = "Pharmacy"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI(){
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: StartVC.reuseID)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func pushPatientVC(){
        let vc = PatientVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    func pushMedicineVC(){
        let vc = MedicineVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushDoctorVC(){
        let vc = DoctorVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension StartVC: UITableViewDelegate, UITableViewDataSource{
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return startDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StartVC.reuseID)!
        
        cell.textLabel?.text = startDataList[indexPath.row].title
        cell.imageView?.image = startDataList[indexPath.row].image
        cell.imageView?.tintColor = .black
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            print("Patient")
            pushPatientVC()
        case 1:
            print("Doctor")
            pushDoctorVC()

        case 2:
            print("Medicine")
            pushMedicineVC()
        default:
            print("Patient")
        }
        
    }
    
    
}





