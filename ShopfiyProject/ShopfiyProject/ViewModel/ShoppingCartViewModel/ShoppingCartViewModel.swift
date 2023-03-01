//
//  ShoppingCartViewModel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 28/02/2023.
//

import Foundation

class ShoppingCartViewModel{
    var bindResultToViewController : (() -> ()) = {}
    
    var shoppingCart : ShoppingCartResponse?{
        didSet{
         //   bindResultToViewController()
        }
    }
    
    var shoppingCartResponse : ShoppingCartResponse! {
        didSet{
            //self.shoppingCart = shoppingCartResponse
            bindResultToViewController()
        }
    }

    func getDraftOrder(url : String?){
        NetworkService.fetchData(url: url) { result in
            self.shoppingCartResponse = result
     //       self.shoppingCartResponse = ShoppingCartResponse()
            
        }
    }
    
}
