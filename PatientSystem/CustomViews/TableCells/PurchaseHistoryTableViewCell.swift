//
//  PurchaseHistoryTableViewCell.swift
//  PatientSystem
//
//  Created by Ahmer on 29/01/2021.
//

import UIKit

class PurchaseHistoryTableViewCell: UITableViewCell {
    
    static let reuseID = "tableViewID"
    
    let transactionIDLabel = UILabel()
    let patientNameLabel = UILabel()
    let medicineNameLabel = UILabel()
    let quantityLabel = UILabel()
    let priceLabel = UILabel()
    let totalBillLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        transactionIDLabel.font = UIFont.systemFont(ofSize: 18)
        medicineNameLabel.font = UIFont.systemFont(ofSize: 18)
    }
    
    private func layoutUI(){
        
        patientNameLabel.translatesAutoresizingMaskIntoConstraints = false
        medicineNameLabel.translatesAutoresizingMaskIntoConstraints = false
        transactionIDLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        totalBillLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(patientNameLabel, medicineNameLabel, transactionIDLabel, quantityLabel, priceLabel, totalBillLabel)
        
        NSLayoutConstraint.activate([
            
            transactionIDLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            transactionIDLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            transactionIDLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            transactionIDLabel.heightAnchor.constraint(equalToConstant: 30),
            
            medicineNameLabel.topAnchor.constraint(equalTo: transactionIDLabel.bottomAnchor, constant: 4),
            medicineNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            medicineNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            medicineNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            quantityLabel.topAnchor.constraint(equalTo: medicineNameLabel.bottomAnchor, constant: 4),
            quantityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            quantityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            quantityLabel.heightAnchor.constraint(equalToConstant: 30),
            
            priceLabel.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            
            totalBillLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            totalBillLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            totalBillLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            totalBillLabel.heightAnchor.constraint(equalToConstant: 30),
            
            patientNameLabel.topAnchor.constraint(equalTo: totalBillLabel.bottomAnchor, constant: 4),
            patientNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            patientNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            patientNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        
    }
    
    func set(purchase : PurchaseModel){
        medicineNameLabel.text = purchase.medicineName
        patientNameLabel.text = purchase.patientName
        transactionIDLabel.text = "Bill ID: \(purchase.transectionID)"
        quantityLabel.text = "Quantity: \(purchase.quantity)"
        priceLabel.text = "Unit Price: $\(purchase.price)"
        totalBillLabel.text = "Total: $\(purchase.totalBill)"
        
    }
}
