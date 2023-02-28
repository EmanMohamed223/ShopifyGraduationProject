//
//  ShoppingCartViewModel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 28/02/2023.
//

import Foundation

class ShoppingCartViewModel{
    var bindResultToViewController : (() -> ()) = {}
    
    var shoppingCart : ShoppingCart?{
        didSet{
            bindResultToViewController()
        }
    }
    
    var shoppingCartResponse : ShoppingCartResponse! {
        didSet{
            self.shoppingCart = shoppingCartResponse.shoppingCart
        }
    }

    func getDraftOrder(url : String?){
        NetworkService.fetchData(url: url) { result in
            self.shoppingCartResponse = result
        }
    }
    
}
