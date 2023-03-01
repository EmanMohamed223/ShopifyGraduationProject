//
//  LoginViewModel.swift
//  ShopfiyProject
//
//  Created by Eman on 27/02/2023.
//

import Foundation
class LoginViewModel {
    var networkservice = NetworkService()
    var customers : [Customer] = []
    var ResultArray : CustomerResponse?
   // var viewModel : CustomerViewModel?
    var viewModel = CustomerViewModel()
//    viewModel.getProducts(url: "")
//    viewModel?.bindResultToViewController = { () in
//
//        self.renderView()
//    }

    func renderView(){
        
        self.ResultArray = self.viewModel.Users
        self.customers = self.ResultArray!.customers
          
        
        
    }
    
    func Login(email: String, password: String, completion: @escaping (Customer?)-> Void){
      
        viewModel.getProducts(url: "https://55d695e8a36c98166e0ffaaa143489f9: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@ios-q2-new-capital-2022-2023.myshopify.com/admin/api/2023-01/customers.json")
        viewModel.bindResultToViewController = { () in
            
            self.renderView()
        }
        var currentCustomer: Customer?
        
        
        for customer in customers {
            if customer.email == email && customer.tags == password {
                currentCustomer = customer
            }
        }
        
        if currentCustomer != nil{
            self.saveCustomerDataToUserDefaults(customer: currentCustomer!)
            completion(currentCustomer)
        } else {
            completion(nil)
        }
    }

    func saveCustomerDataToUserDefaults(customer: Customer){
        guard let customerID = customer.id else {return}
        guard let userFirstName = customer.first_name else {return}
        guard let userEmail = customer.email  else {return}

        UserDefaultsManager.shared.setUserID(customerID: customerID)
        UserDefaultsManager.shared.setUserName(userName: userFirstName)
        UserDefaultsManager.shared.setUserEmail(userEmail: userEmail)
    }
    
}
