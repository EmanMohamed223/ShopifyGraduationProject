//
//  FormatingDictionary.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 20/12/1401 AP.
//

import Foundation
func convertter(lineItems : [LineItem]) -> [[String : Any]]{
    
    
    var DicLineItems : [[String : Any]] = []
    for item in lineItems{
        let temp : [String : Any] =
        [    "fullfillabel_quantity" : item.fullfillabel_quantity ?? "",
             "name": item.name ?? "",
             "price": item.price ?? "",
             "quantity" : item.quantity ?? 0,
             "sku" :  item.sku ?? "",
             "title" :  item.title ?? ""
        ]
        DicLineItems.append(temp)
    }
    
    return DicLineItems
}
func SplitAddress(address: String?) -> [String]{
    let components = address?.components(separatedBy: ",")
    return components ?? []
}
