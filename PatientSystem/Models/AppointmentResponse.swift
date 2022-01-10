//
//  AppointmentResponse.swift
//  PatientSystem
//
//  Created by Ahmer on 24/01/2021.
//

import Foundation

struct AppointmentResponse : Codable {
    let error : Bool
    let appointments: [AppointmentDetails]
}

struct AppointmentDetails : Codable {
    
    let patientName : String
    let appointmentDate: String
    let doctorName : String
    
}
