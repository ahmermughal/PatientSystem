//
//  PrescriptionTableViewCell.swift
//  PatientSystem
//
//  Created by Ahmer on 24/01/2021.
//

import UIKit

class PrescriptionTableViewCell: UITableViewCell {

    static let reuseID = "tableViewID"
    
    let patientNameLabel = UILabel()
    let medicineNameLabel = UILabel()
    let doctorNameLabel = UILabel()
    let prescriptionDate = UILabel()
    let intakeDetails = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        medicineNameLabel.font = UIFont.systemFont(ofSize: 18)
        prescriptionDate.font = UIFont.systemFont(ofSize: 12)
    }
    
    private func layoutUI(){
        
        patientNameLabel.translatesAutoresizingMaskIntoConstraints = false
        medicineNameLabel.translatesAutoresizingMaskIntoConstraints = false
        doctorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        prescriptionDate.translatesAutoresizingMaskIntoConstraints = false
        intakeDetails.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(patientNameLabel, medicineNameLabel, doctorNameLabel, prescriptionDate, intakeDetails)
        
        NSLayoutConstraint.activate([
        
            medicineNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            medicineNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            medicineNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            medicineNameLabel.heightAnchor.constraint(equalToConstant: 40),
   
            patientNameLabel.topAnchor.constraint(equalTo: medicineNameLabel.bottomAnchor, constant: 4),
            patientNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            patientNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            patientNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            doctorNameLabel.topAnchor.constraint(equalTo: patientNameLabel.bottomAnchor, constant: 4),
            doctorNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            doctorNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            doctorNameLabel.heightAnchor.constraint(equalToConstant: 30),

            intakeDetails.topAnchor.constraint(equalTo: doctorNameLabel.bottomAnchor, constant: 4),
            intakeDetails.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            intakeDetails.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            intakeDetails.heightAnchor.constraint(equalToConstant: 30),

            prescriptionDate.topAnchor.constraint(equalTo: intakeDetails.bottomAnchor, constant: 4),
            prescriptionDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            prescriptionDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            prescriptionDate.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        
    }
    
    func set(pres : PrescriptionDetails){
        
        medicineNameLabel.text = pres.medicineName
        patientNameLabel.text = pres.patientName
        doctorNameLabel.text = pres.doctorName
        intakeDetails.text = pres.intakeDetails
        let timeIntervel = TimeInterval(pres.prescriptionDate)
        let date = Date(timeIntervalSince1970: timeIntervel!)
        prescriptionDate.text = date.formattedDateString()
        
    }
    
}
