//
//  UIView+Ext.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import UIKit

extension UIView{
    
    func pinToEdges(of superview: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    // ... makes so any number of views can be passed it
    func addSubviews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
}
