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
        NetworkService.fetchData(url: url) { result in
            self.resultProducts = result
   
        }
    }
    var bindResultToHomeViewController : (() -> ()) = {}
     var resultBrands : SmartCollection! {
         didSet{
             bindResultToHomeViewController()
         }
     }
    func getBrands(url : String?){
        NetworkService.fetchData(url: url) { result in
            self.resultBrands = result
        }
    }
    
    func getOffers(url : String){
        
    }
  
}
