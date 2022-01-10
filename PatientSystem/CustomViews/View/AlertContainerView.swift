//
//  AlertContainerView.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import UIKit

class AlertContaninerView: UIView {
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         configure()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     private func configure(){
         backgroundColor = .systemBackground
         layer.cornerRadius = 16
         layer.borderWidth = 2
         layer.borderColor = UIColor.black.cgColor
         translatesAutoresizingMaskIntoConstraints = false
     }   
}
