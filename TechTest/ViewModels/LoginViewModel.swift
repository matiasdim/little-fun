//
//  LoginViewModel.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 23/10/21.
//

import Foundation

struct LoginViewModel {
    var user: User
    
    var email: String?
    var password: String?
        
    var validateFields: (() -> Bool)?
    var setUser: (() -> Bool)?
    var showError: (()->())?
    var dismissVC: (()->())?
    var persistancehandler: PersistanceDataHandler
    
    func login() {
        if validateFields?() == true {
            dismissVC?()
        } else {
            showError?()
        }
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return email.range(of: emailRegExp, options: .regularExpression) != nil
    }
    
    mutating func setUser(email: String, password: String) {
        user.email = email
        user.password = password
        persistUser()
    }
    
    private func persistUser() {
        persistancehandler.set(object: ["email": user.email, "password": user.password], forKey: "user")        
    }
        
}

