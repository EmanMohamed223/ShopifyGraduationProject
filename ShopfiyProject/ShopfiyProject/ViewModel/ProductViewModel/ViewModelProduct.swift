//
//  ViewModel.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 04/12/1401 AP.
//

import Foundation
class ViewModelProduct{
    var bindResultToViewController : (() -> ()) = {}
     
     
     var resultProducts : ResponseProducts! {
         didSet{
             bindResultToViewController()
         }
     }
     
     func getProducts(url : String?){
         NetworkService.shared.fetchData(url: url) { result in
             self.resultProducts = result
    
         }
     }
   
     
     func getOffers(url : String){
         
     }
    func callNetworkServiceManagerToPut(draftOrder : ShoppingCartResponse, completion: @escaping (HTTPURLResponse) -> ()){
        NetworkServiceManager.shared.callNetworkServiceToPutDraftOrder(draftOrder: draftOrder) { response in
            completion(response ?? HTTPURLResponse())
        }
    }
    
   
    
    
    
    
    
    
    
    
   
 }
