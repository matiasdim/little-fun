//
//  PersistanceDataHandler.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 27/10/21.
//

import Foundation

struct PersistanceDataHandler {
    func set(object: Any, forKey key: String) {
        UserDefaults.standard.setValue(object, forKey: key)
    }
    
    func set(data: Data, forKey key: String) {
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    func getObject(forKey key: String) -> Data? {
        return UserDefaults.standard.object(forKey: key) as? Data
    }
    
    private func getData(forKey key: String) -> Data? {
        return UserDefaults.standard.object(forKey: key) as? Data
    }
}
