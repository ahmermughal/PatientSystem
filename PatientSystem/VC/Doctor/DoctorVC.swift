//
//  DoctorVC.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import UIKit

class DoctorVC: UIViewController {

    private static let reuseID = "doctorCellID"
    
    let dataList : [OptionsModel] = OptionsModel.getDoctorVCData()
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureUI()
        //layoutUI()
    }
    
    private func configureVC(){
        title = "Doctor"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI(){
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: DoctorVC.reuseID)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }


    func pushCreateDoctorVC(){
        let vc = CreateDoctorVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushDeleteDoctorVC(){
        let vc = DeleteDoctorVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    func pushUpdateDoctorVC(){
        let vc = UpdateDoctorVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension DoctorVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DoctorVC.reuseID)!
        
        cell.textLabel?.text = dataList[indexPath.row].title
        cell.imageView?.image = dataList[indexPath.row].image
        cell.imageView?.tintColor = .black
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            pushCreateDoctorVC()
        }else if indexPath.row == 1{
            pushDeleteDoctorVC()
        }else if indexPath.row == 2 {
            pushUpdateDoctorVC()
        }
    }
    
}
