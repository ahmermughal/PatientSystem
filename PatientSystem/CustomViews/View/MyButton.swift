//
//  MyButton.swift
//  PatientSystem
//
//  Created by Ahmer on 21/01/2021.
//

import UIKit

class MyButtonView: UIView {
    
    let colorView = UIView()
    let border = UIView()
    let label = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        layoutUI()
    }
    
    convenience init(text: String, frame: CGRect) {
        self.init(frame: frame)
        label.text = text.uppercased()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        colorView.backgroundColor = MyColors.accent
        border.layer.borderWidth = 2
        colorView.layer.cornerRadius = 10
        border.layer.cornerRadius = 10
        label.textAlignment = .center
    }
    
    func layoutUI(){
        colorView.translatesAutoresizingMaskIntoConstraints = false
        border.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(colorView)
        self.addSubview(border)
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            
            colorView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            colorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            
//            border.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
//            border.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
//            border.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4),
//            border.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4),
            border.widthAnchor.constraint(equalToConstant: self.frame.width - 2),
            border.heightAnchor.constraint(equalToConstant: self.frame.height - 2),
            border.centerXAnchor.constraint(equalTo: colorView.centerXAnchor, constant: -4),
            border.centerYAnchor.constraint(equalTo: colorView.centerYAnchor, constant: -4),
            
           label.widthAnchor.constraint(equalToConstant: self.frame.width),
           label.heightAnchor.constraint(equalToConstant: self.frame.height),
           label.centerXAnchor.constraint(equalTo: colorView.centerXAnchor, constant: -4),
           label.centerYAnchor.constraint(equalTo: colorView.centerYAnchor, constant: -4),
           
        ])
        
    }
    
}
