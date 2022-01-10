//
//  PatientModel.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import Foundation


struct PatientModel: Codable {
    
    let name: String
    let sex : String
    let phone: String
    let address : String
    var pid : Int = -22    
    
}
