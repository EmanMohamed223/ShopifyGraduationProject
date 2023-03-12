//
//  DraftOrderViewModel.swift
//  ShopfiyProject
//
//  Created by Eman on 01/03/2023.
//

import Foundation

class DraftOrderViewModel
{

    /*func createNewDraft(newDraftOrder: DraftOrder, completion:@escaping (Data?, HTTPURLResponse? , Error?)->()){
        //obg mn l protocol
        NetworkService.shared.addToDraftOrder(newDraft: newDraftOrder) { data, response, error in
            guard error == nil else {
                completion(nil, nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, response as? HTTPURLResponse, error)
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
            _ = json["draft_order"] as? Dictionary<String,Any>
           
           
            completion(data, response as? HTTPURLResponse, nil)
            
        }
    }*/
}
