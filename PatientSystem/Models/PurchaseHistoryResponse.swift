//
//  PurchaseHistoryResponse.swift
//  PatientSystem
//
//  Created by Ahmer on 29/01/2021.
//

import Foundation


struct PurchaseHistoryResponse : Codable {
    
    let error : Bool
    let patientPurchaseHistory: [PurchaseModel]
    
}

struct PurchaseModel : Codable {
    
    let patientID: Int
    let patientName: String
    let transectionID: Int
    let medicineName: String
    let price: Double
    let quantity: Int
    let totalBill: Double
    
}
