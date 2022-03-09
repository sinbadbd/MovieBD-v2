//
//  UserDefaultManager.swift
//  MovieDB-v2
//
//  Created by Imran on 3/9/20.
//  Copyright © 2020 portonics. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case user_id
        case user_name
        case user_dob
        case user_email
        case user_phone
        case user_create_at
        case user_update_at
        case online_status
        case login_status
        case seesionToken
        
    }
    
    
    
    func setUserId(value : Int){
        setValue(value, forKey: UserDefaultsKeys.user_id.rawValue)
    }
    
    func getUserId() -> Int {
        return integer(forKey: UserDefaultsKeys.user_id.rawValue)
    }
    
    func setEmail(value : String){
        setValue(value, forKey: UserDefaultsKeys.user_email.rawValue)
    }
    
    func getEmail() -> String {
        return string(forKey: UserDefaultsKeys.user_email.rawValue)!
    }
    
    
    func setUserName(value : String){
        setValue(value, forKey: UserDefaultsKeys.user_name.rawValue)
    }
    
    func getUserName() -> String {
        return string(forKey: UserDefaultsKeys.user_name.rawValue)!
    }
    
    
    
    
    func setDateOfBirth(value : String){
        setValue(value, forKey: UserDefaultsKeys.user_dob.rawValue)
    }
    
    func getDateOfBirth() -> String {
        return string(forKey: UserDefaultsKeys.user_dob.rawValue)!
    }
    
    
    
    
    func setLoginSatus(value: Bool)  {
        set(value, forKey: UserDefaultsKeys.login_status.rawValue)
    }
    
    func getLoginSatus() -> Bool {
        return bool(forKey: UserDefaultsKeys.login_status.rawValue)
    }
    
   
    
    func setMobile(value: String)  {
        set(value, forKey: UserDefaultsKeys.user_phone.rawValue)
    }
    
    func getMobile() -> String {
        return string(forKey: UserDefaultsKeys.user_phone.rawValue)!
    }
    
    func setOnlineStatus(value: Int)  {
        set(value, forKey: UserDefaultsKeys.online_status.rawValue)
    }
    
    func getOnlineStatus() -> Int {
        return integer(forKey: UserDefaultsKeys.online_status.rawValue)
    }
    
    func setSessionToken(value : String) {
       setValue(value, forKey: UserDefaultsKeys.seesionToken.rawValue)
    }
    func getSessionToken() -> String {
           return string(forKey: UserDefaultsKeys.seesionToken.rawValue)!
       }
    

    func clearUserDefault() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
    
}
