//
//  LoginViewModel.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 23/10/21.
//

import Foundation

struct LoginViewModel {
    var user: User
    
    var username: String?
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
    
    mutating func setUser(username: String, password: String) {
        user.username = username
        user.password = password
        persistUser()
    }
    
    private func persistUser() {
        UserDefaults.standard.setValue(["username": user.username, "password": user.password], forKey: "user")
    }
        
}

