//
//  CustomerViewModel.swift
//  ShopfiyProject
//
//  Created by Eman on 27/02/2023.
//

import Foundation
class CustomerViewModel{
    
    var bindResultToViewController : (() -> ()) = {}
    var Users : CustomerResponse! {
        didSet{
            bindResultToViewController()
        }
    }
    
    func getProducts(url : String?){
        NetworkService.fetchData(url: url) { result in
            self.Users = result
            
        }
    }
}
