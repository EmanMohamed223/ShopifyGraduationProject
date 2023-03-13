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
    
    var shoppingCartResponseArray : ShoppingCartResponseArray! {
        didSet{
            bindResultToViewController()
        }
    }

    func getDraftOrder(url : String?){
        NetworkService.shared.fetchData(url: url) { result in
            self.shoppingCartResponseArray = result
        }
    }
    
    func getOneDraftOrder(url : String?){
        NetworkService.shared.fetchData(url: url) { result in
            self.shoppingCartResponse = result
        }
    }
    
    func deleteDraftOrder(url : String?){
        NetworkService.shared.deleteDraftOrder(url: url ?? "") { error in
            if error != nil{
                print(error)
            }
        }
    }
    
    
}
