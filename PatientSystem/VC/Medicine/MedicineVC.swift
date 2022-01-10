//
//  MedicineVC.swift
//  PatientSystem
//
//  Created by Ahmer on 22/01/2021.
//

import UIKit

class MedicineVC: UIViewController {
    
    private static let reuseID = "MedicineCellID"
    
    let dataList : [OptionsModel] = OptionsModel.getMedicineVCData()
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureUI()
        //layoutUI()
    }
    
    private func configureVC(){
        title = "Medicine"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI(){
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MedicineVC.reuseID)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    
    
    
    func pushBuyMedicineVC(){
        let vc = BuyMedicineVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushCreateMedicineVC(){
        let vc = CreateMedicineVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushDeleteMedicineVC(){
        let vc = DeleteMedicineVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func pushUpdateMedicineVC(){
        let vc = UpdateMedicineVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushPrescribeMedicineVC(){
        let vc = PrescribeMedicineVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushPatientPrescriptionsVC(){
        let vc = PatientPrescriptionsVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    func pushPurchaseHistoryVC(){
        let vc = PurchaseHistoryVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MedicineVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MedicineVC.reuseID)!
        
        cell.textLabel?.text = dataList[indexPath.row].title
        cell.imageView?.image = dataList[indexPath.row].image
        cell.imageView?.tintColor = .black
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            pushCreateMedicineVC()
            
        }else if indexPath.row == 1 {
            pushDeleteMedicineVC()
        }else if indexPath.row == 2 {
            pushBuyMedicineVC()
        }else if(indexPath.row == 3){
            pushPrescribeMedicineVC()
        }else if (indexPath.row == 4){
            pushPatientPrescriptionsVC()
        }else {
            pushPurchaseHistoryVC()
        }
    }
    
    
}
