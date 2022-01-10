//
//  UIVC+Ext.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import UIKit
extension UIViewController{
    
    func displayAlert(title: String?, message: String){
        DispatchQueue.main.async {
            let alertVC = AlertVC(title: title, message: message)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
        
    }
    
}
