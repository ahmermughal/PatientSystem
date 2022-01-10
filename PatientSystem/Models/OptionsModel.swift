//
//  StartVCModel.swift
//  PatientSystem
//
//  Created by Ahmer on 21/01/2021.
//

import UIKit


struct OptionsModel {
    let title: String
    let image: UIImage
    
    static func getStartVCData() -> [OptionsModel] {
        var startDataList : [OptionsModel] = []
        
        startDataList.append(OptionsModel(title: "Patient", image: UIImage(named: "user")!))
        startDataList.append(OptionsModel(title: "Doctor", image: UIImage(named: "doctor")!))
        startDataList.append(OptionsModel(title: "Medicine", image: UIImage(named: "medicine")!))
        return startDataList
    }

    static func getPatientVCData() -> [OptionsModel] {
        var list : [OptionsModel] = []
        
        list.append(OptionsModel(title: "Add Patient", image: UIImage(named: "user-create")!))
        list.append(OptionsModel(title: "Delete Patient", image: UIImage(named: "user-delete")!))
        list.append(OptionsModel(title: "Update Patient", image: UIImage(named: "user-update")!))
        
        list.append(OptionsModel(title: "Make Appointment", image: UIImage(named: "appointment-make")!))
        list.append(OptionsModel(title: "Cancel Appointment", image: UIImage(named: "appointment-make")!))

        list.append(OptionsModel(title: "Patient Details", image: UIImage(named: "user")!))
        list.append(OptionsModel(title: "Patient Appointments", image: UIImage(named: "appointment-details")!))
        list.append(OptionsModel(title: "All Patient", image: UIImage(named: "user")!))

        
        return list
    }
    
    static func getMedicineVCData() -> [OptionsModel] {
        var list : [OptionsModel] = []
        
        list.append(OptionsModel(title: "Add Medicine", image: UIImage(named: "medicine")!))
        list.append(OptionsModel(title: "Delete Medicine", image: UIImage(named: "medicine")!))
        
        list.append(OptionsModel(title: "Buy Medicine", image: UIImage(named: "buy")!))
        list.append(OptionsModel(title: "Prescribe Medicine", image: UIImage(named: "prescription")!))

        list.append(OptionsModel(title: "Patient Prescribed Medicines", image: UIImage(named: "prescription")!))
        list.append(OptionsModel(title: "Patient Purchase History", image: UIImage(named: "prescription")!))

        return list
    }

    static func getDoctorVCData() -> [OptionsModel] {
        var list : [OptionsModel] = []
        
        list.append(OptionsModel(title: "Add Doctor", image: UIImage(named: "medicine")!))
        list.append(OptionsModel(title: "Delete Doctor", image: UIImage(named: "user-delete")!))
        list.append(OptionsModel(title: "Update Doctor", image: UIImage(named: "user-update")!))
        
        return list
    }
    
}
