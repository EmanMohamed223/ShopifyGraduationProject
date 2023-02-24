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
        return !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword
    }
    
    func ValdiateCustomerInfomation(firstName: String, email: String, password: String, confirmPassword: String, compeltion: @escaping (String?) ->Void){
        
        if firstName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            compeltion("ErrorAllInfoIsNotFound")
            return
        }
        
        if !isValidEmail(email) {
            compeltion("ErrorEmail")
            return
        }
        
        if !isValidPassword(password: password, confirmPassword: confirmPassword) {
            compeltion("ErrorPassword")
            return
        }
    }
    
    
    
}
