//
//  Date+Ext.swift
//  PatientSystem
//
//  Created by Ahmer on 24/01/2021.
//

import UIKit


extension Date{
    
    func formattedDateString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: self)
    }

    func formattedTimeString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter.string(from: self)
    }
    
    
}
