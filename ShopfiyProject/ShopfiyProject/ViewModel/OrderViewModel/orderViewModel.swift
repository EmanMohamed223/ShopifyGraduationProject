//
//  orderViewModel.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 12/12/1401 AP.
//

import Foundation
class orderViewModel{
    var bindResultToOrderViewController : (() -> ()) = {}
   
     var resultOrders : Orders! {
         didSet{
             bindResultToOrderViewController()
         }
     }
  
    func getOrders(url : String?){
        NetworkService.fetchData(url: url) { result in
            self.resultOrders = result
           
           
        }
    }
    func postOrder( order: [String : Any]){

        NetworkService.postDataToApi(url: getURL(endPoint: "orders.json")!, newOrder: order)
       
    }
}
