//
//  ShoppingCartViewModel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 28/02/2023.
//

import Foundation

class ShoppingCartViewModel{
    
    var bindResultToViewController : (() -> ()) = {}
    
    var shoppingCartResponse : ShoppingCartResponse! {
        didSet{
            bindResultToViewController()
        }
    }

    func getDraftOrder(url : String?){
        NetworkService.shared.fetchData(url: url) { result in
            self.shoppingCartResponse = result
        }
    }
    
}
