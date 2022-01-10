//
//  PatientResponse.swift
//  PatientSystem
//
//  Created by Ahmer on 29/01/2021.
//

import Foundation

struct PatientResponse : Codable {
    
    let error : Bool
    let patients: [PatientModel]
    
    
}
