//
//  MyErrors.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import Foundation


enum MyError: String, Error{
    
    case invalidResponse = "Invalid response from the server. Please Try Again."
    case invalidData = "The data received from the server was invalid. Please Try Again."
    case invalidURL = "The query is invalid."
}

