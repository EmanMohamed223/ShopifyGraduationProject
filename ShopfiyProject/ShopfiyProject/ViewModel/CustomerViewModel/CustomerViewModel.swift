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
    
    func getcustomers(url : String?){
        NetworkService.shared.fetchData(url: url) { result in
            self.Users = result
            
        }
    }
}
