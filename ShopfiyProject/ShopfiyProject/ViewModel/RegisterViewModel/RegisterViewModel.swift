//
//  RegisterViewModel.swift
//  ShopfiyProject
//
//  Created by Eman on 24/02/2023.
//

import Foundation
class RegisterViewModel {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
        //!email.isEmpty
    }
    
    func isValidPassword(password: String, confirmPassword: String) -> Bool{
        return !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword && password.count > 8
        
        
    }
    
    
    func isValidname(name: String) -> Bool{
        return name.first!.isLetter && name.count > 8
        
        
    }
    func isValidphone(phoneNumber: String) -> Bool{
        return phoneNumber.count == 11
        
        
    }
    func isValidAddress(address add: String) -> Bool{
        let addRegEx = "[A-Za-z]+,[A-Za-z]+,[A-Za-z]+"
        let addPred = NSPredicate(format:"SELF MATCHES %@", addRegEx)
        return addPred.evaluate(with: add)
        
        
    }
    
    func ValdiateCustomerInfomation(firstName: String, email: String, password: String, confirmPassword: String,phone : String, address : String, compeltion: @escaping (String?) ->Void){
        
        if firstName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty||phone.isEmpty || address.isEmpty {
            compeltion("ErrorAllInfoIsNotFound")
            return
        }
        
        if !isValidEmail(email) {
            compeltion("ErrorEmail")
            return
        }
        if !isValidAddress(address: address) {
            compeltion("ErrorAddress")
            return
        }
        if !isValidname(name: firstName) {
            compeltion("ErroruserName")
            return
        }
        
        if !isValidPassword(password: password, confirmPassword: confirmPassword) {
            compeltion("ErrorPassword")
            return
        }
        if !isValidphone(phoneNumber: phone) {
                compeltion("ErrorPhone")
                return
        }
    }
    
    
    
    
    func createNewCustomer(newCustomer: User, completion:@escaping (Data?, HTTPURLResponse? , Error?)->()){
        //obg mn l protocol
        NetworkService.shared.register(newCustomer: newCustomer) { data, response, error in
            guard error == nil else {
                completion(nil, nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, response as? HTTPURLResponse, error)
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
            let customer = json["customer"] as? Dictionary<String,Any>
            self.saveCustomerDataToUserDefaults(customer: customer)
            completion(data, response as? HTTPURLResponse, nil)
            
        }
    }
    
    func saveCustomerDataToUserDefaults(customer: Dictionary<String,Any>?) {
        
        let customerID = customer?["id"] as? Int ?? 0
        let customerFirstName = customer?["first_name"] as? String ?? ""
        let customerEmail = customer?["email"] as? String ?? ""
        
        UserDefaultsManager.shared.setUserID(customerID: customerID)
        UserDefaultsManager.shared.setUserName(userName: customerFirstName)
        UserDefaultsManager.shared.setUserEmail(userEmail: customerEmail)
        UserDefaultsManager.shared.setUserStatus(userIsLogged: false)
    }
    
}
    
    
    
    
    
    
    
    
    
    

