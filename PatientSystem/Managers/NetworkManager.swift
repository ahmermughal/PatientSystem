//
//  NetworkManager.swift
//  PatientSystem
//
//  Created by Ahmer on 23/01/2021.
//

import Foundation
class NetworkManager{
    
    static let shared = NetworkManager()
    private let baseURL = "http://192.168.100.11:8080/CepAPI/public"
    private let requestHeaders : [String:String] = [
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    private init(){}
    
    
    // MARK: Patient
    func createPatient(of patient: PatientModel, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/createpatient"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
        
        var requestBodyComponents = URLComponents()
        
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "PatientName", value: patient.name),
            URLQueryItem(name: "Sex", value: patient.sex),
            URLQueryItem(name: "Phone", value: patient.phone),
            URLQueryItem(name: "Home", value: patient.address)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = requestHeaders
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 201 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }

    func deletePatient(of patientID: String, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/deletepatient/\(patientID)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
   
    func getPatient(of patientID: String, completed: @escaping (Result<PatientModel, MyError>) -> Void){
                
        let endpoint = baseURL + "/getpatientbyid/\(patientID)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
           
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(PatientModel.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getAllPatient(completed: @escaping (Result<PatientResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/getallpatients"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
           
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(PatientResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func updatePatient(of patient: PatientModel, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
        print(patient)
        let endpoint = baseURL + "/updatepatient/\(patient.pid)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
        
        var requestBodyComponents = URLComponents()
        
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "Phone", value: patient.phone),
            URLQueryItem(name: "Home", value: patient.address),
            URLQueryItem(name: "P_ID", value: String(patient.pid)),
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = requestHeaders
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    // MARK: Doctor
    
    func createDoctor(of doctor: DoctorModel, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/createdoctor"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
        
        var requestBodyComponents = URLComponents()
        
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "DoctorName", value: doctor.name),
            URLQueryItem(name: "Qualification", value: doctor.qualification)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = requestHeaders
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 201 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func deleteDoctor(of doctorID: String, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/deletedoctor/\(doctorID)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func updateDoctor(of doctor: DoctorModel, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
        let endpoint = baseURL + "/updatedoctor/\(doctor.dID)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
        
        var requestBodyComponents = URLComponents()
        
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "Qualification", value: doctor.qualification),
            URLQueryItem(name: "D_ID", value: String(doctor.dID)),
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = requestHeaders
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getDoctor(of doctorID: String, completed: @escaping (Result<DoctorModel, MyError>) -> Void){
                
        let endpoint = baseURL + "/getdoctorbyid/\(doctorID)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
           
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DoctorModel.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    // MARK: Medicine
    func createMedicine(of medicine: MedicineModel, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/createmedicine"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
        
        var requestBodyComponents = URLComponents()
        
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "MedicineName", value: medicine.name),
            URLQueryItem(name: "Quantity", value: medicine.quantity),
            URLQueryItem(name: "Salts", value: medicine.salts),
            URLQueryItem(name: "ManufactureDate", value: medicine.ManudactureDate),
            URLQueryItem(name: "ExpireDate", value: medicine.ExpDate),
            URLQueryItem(name: "Price", value: medicine.price),
            URLQueryItem(name: "RefundPolicy", value: medicine.refundPolicy),
            URLQueryItem(name: "ManufacturerID", value: medicine.manID),
            URLQueryItem(name: "MedicineTypeID", value: medicine.typeID)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = requestHeaders
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 201 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func deleteMedicine(of medicineID: String, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/deletemedicine/\(medicineID)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func createPrescription(of prescription: PrescriptionModel, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/createprescribed"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
        
        var requestBodyComponents = URLComponents()
        
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "PrescriptionDate", value: prescription.prescriptionDate),
            URLQueryItem(name: "IntakeDetails", value: prescription.intakeDetails),
            URLQueryItem(name: "Quantity", value: String(prescription.quantity)),
            URLQueryItem(name: "DoctorID", value: String(prescription.doctorID)),
            URLQueryItem(name: "PatientID", value: String(prescription.patientID)),
            URLQueryItem(name: "MedicineID", value: String(prescription.medID))
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = requestHeaders
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 201 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getPrescriptionByID(of patientID: String, completed: @escaping (Result<PrescriptionRespose, MyError>) -> Void){
                
        let endpoint = baseURL + "/getpatientsprescriptions/\(patientID)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
           
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(PrescriptionRespose.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getPurchaseHistoryByID(of patientID: String, completed: @escaping (Result<PurchaseHistoryResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/getpatientpurchasehistory/\(patientID)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
           
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(PurchaseHistoryResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func buyMedicine(of prescription: PrescriptionModel, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/createbuys"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
        
        var requestBodyComponents = URLComponents()
        
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "Quantity", value: String(prescription.quantity)),
            URLQueryItem(name: "PatientID", value: String(prescription.patientID)),
            URLQueryItem(name: "MedicineID", value: String(prescription.medID))
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = requestHeaders
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 201 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    // MARK: Appointment
    func createAppointment(of appointment: AppointmentModel, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/createappointment"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
        
        var requestBodyComponents = URLComponents()
        
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "PatientID", value: appointment.patientID),
            URLQueryItem(name: "DoctorID", value: appointment.doctorID),
            URLQueryItem(name: "AppointmentDay", value: appointment.appointmentDay)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = requestHeaders
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 201 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func createAssignedTo(of appointment: AppointmentModel, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/createassignedto"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
        
        var requestBodyComponents = URLComponents()
        
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "PatientID", value: appointment.patientID),
            URLQueryItem(name: "DoctorID", value: appointment.doctorID)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = requestHeaders
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 201 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
  
  
    func cancelAppointment(of appointmentID: String, completed: @escaping (Result<DefaultResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/deleteappointment/\(appointmentID)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(DefaultResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
   
    func getAppointmentsByID(of patientID: String, completed: @escaping (Result<AppointmentResponse, MyError>) -> Void){
                
        let endpoint = baseURL + "/getpatientsappointments/\(patientID)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidURL))
            return
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // if error is not null
            if let _ = error{
                completed(.failure(.invalidURL))
                return
            }
            
            // if this response is not nill and the status code is 200
            // else response is nill
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
           
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(AppointmentResponse.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    
}
