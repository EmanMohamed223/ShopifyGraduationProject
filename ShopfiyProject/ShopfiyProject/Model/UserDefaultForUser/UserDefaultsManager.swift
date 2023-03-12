//
//  UserDefaultsManager.swift
//  ShopfiyProject
//
//  Created by Eman on 26/02/2023.
//

import Foundation
class UserDefaultsManager{
    
    static let shared = UserDefaultsManager()
    
    private init() {
        
    }
    
    func setCouponStatus(coupon : Bool){
        UserDefaults.standard.set(coupon, forKey: "couponStatus")
    }
    
    func getCouponStatus()->Bool{
        return UserDefaults.standard.bool(forKey: "couponStatus")
    }
    
    func setCurrencyFlag(currency : String?){
        UserDefaults.standard.set(currency, forKey: "currencyFlag")
    }
    
    func getCurrencyFlag() -> String?{
        return UserDefaults.standard.string(forKey: "currencyFlag")
    }
    
    func setCurrency(currency : String?){
        UserDefaults.standard.set(currency, forKey: "currency")
    }
    
    func getCurrency() -> String?{
        return UserDefaults.standard.string(forKey: "currency")
    }
    
    func setUserID(customerID: Int?){
        UserDefaults.standard.set(customerID, forKey: "User_ID")
    }
    
    func getUserID()-> Int?{
        return UserDefaults.standard.integer(forKey: "User_ID")
    }
    func setDraftOrderID(draftOrderID: Int?){
        UserDefaults.standard.set(draftOrderID, forKey: "DraftOrder_ID")
    }
    
    func getDraftOrderID()-> Int?{
        return UserDefaults.standard.integer(forKey: "DraftOrder_ID")
    }
    
    func setUserName(userName: String?){
        UserDefaults.standard.set(userName, forKey: "User_Name")
    }
    
    func getUserName()-> String?{
        return UserDefaults.standard.string(forKey: "User_Name")
    }
    
    func setUserEmail(userEmail: String?){
        UserDefaults.standard.set(userEmail, forKey: "User_Email")
    }
    
    func getUserEmail()-> String?{
        return UserDefaults.standard.string(forKey: "User_Email")
    }
    
    func setUserStatus(userIsLogged: Bool){
        UserDefaults.standard.set(userIsLogged, forKey: "User_Status")
    }
    
    func getUserStatus()-> Bool{
        return UserDefaults.standard.bool(forKey: "User_Status")
    }
    
    func setDraftFlag(draftFlag: Bool){
        UserDefaults.standard.set(draftFlag, forKey: "draftOrderFlag")
    }
    

    func getDraftFlag()-> Bool{
        return UserDefaults.standard.bool(forKey: "draftOrderFlag")
    }

}
