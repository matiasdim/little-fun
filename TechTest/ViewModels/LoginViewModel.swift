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
    
    func login() {
        if validateFields?() == true {
            dismissVC?()
        } else {
            showError?()
        }
    }
    
    mutating func setUser(email: String, password: String) {
        user.email = email
        user.password = password
        persistUser()
    }
    
    private func persistUser() {
        UserDefaults.standard.setValue(["email": user.email, "password": user.password], forKey: "user")
    }
        
}

