//
//  PrescriptionResponse.swift
//  PatientSystem
//
//  Created by Ahmer on 24/01/2021.
//

import Foundation

struct PrescriptionRespose : Codable {
    let error: Bool
    let prescriptions: [PrescriptionDetails]
}

struct PrescriptionDetails : Codable {
    
    let patientName : String
    let medicineName : String
    let doctorName : String
    let prescriptionDate: String
    let intakeDetails: String
    let quantity: Int
    
}
