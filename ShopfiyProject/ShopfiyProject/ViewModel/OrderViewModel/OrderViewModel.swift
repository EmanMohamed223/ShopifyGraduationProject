//
//  OrderViewModel.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 13/12/1401 AP.
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
        
        NetworkService.shared.fetchData(url: url) { result in
            self.resultOrders = result
            
            
        }
    }
    func postOrder( order: [String : Any]){
   
        NetworkService.shared.postDataToApi(url: getURL(endPoint: "orders.json")!, newOrder: order) { response in
            print(response)
        }
      
        
    }

}
