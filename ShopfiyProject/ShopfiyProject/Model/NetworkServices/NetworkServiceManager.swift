//
//  NetworkServiceManager.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 04/03/2023.
//

import Foundation

class NetworkServiceManager : PostAddressProtocol, EditAddressProtocol, DeleteAddressProtocol , EditDraftOrderProtocol{
   
    
    
    static let shared = NetworkServiceManager()
    static var addresses : CustomerAddressGetModel!
    static var response = HTTPURLResponse()
    private init(){}
    
    func callNetworkServiceToPostAddress(customerAddressModel : CustomerAddressModel,completion: @escaping (HTTPURLResponse?)->()){
        NetworkService.shared.postAddress(customerAddressModel: customerAddressModel, completion: { data, response, error in
            print(response ?? "") //200...299
            completion(response)
        })
    }
    
    func callNetworkServiceToPutAddress(customerAddressModel : CustomerAddressModel,completion: @escaping (HTTPURLResponse?)->()){
        NetworkService.shared.putAddress(customerAddressModel: customerAddressModel, completion: { data, response, error in
            print(response ?? "")
            completion(response)
        })
    }
    
    func callNetworkServiceToDeleteAddress(customerAddressModel : CustomerAddressModel){
        NetworkService.shared.deleteAddress(customerAddressModel: customerAddressModel, completion: { data, response, error in
            print(response ?? "")
        })
    }
    
    func callNetworkServiceToGetAddress(url : String?,compilation : @escaping (CustomerAddressGetModel)->()){
        NetworkService.shared.fetchData(url: url) { result in
            NetworkServiceManager.addresses = result
        }
    }
    func callNetworkServiceToPutDraftOrder(draftOrder: ShoppingCartResponse, completion: @escaping (HTTPURLResponse?) -> ()) {
        NetworkService.shared.putDraft(draftOrderModel: draftOrder, completion: { data, response, error in
            print(response ?? "")
            completion(response)
        })
    }
}
