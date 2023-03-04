//
//  NetworkServiceManager.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 04/03/2023.
//

import Foundation

class NetworkServiceManager{
    
    static let shared = NetworkServiceManager()
    static var addresses : CustomerAddressGetModel!
    private init(){}
    
    func callNetworkServiceToPostAddress(customerAddressModel : CustomerAddressModel){
        NetworkService.shared.postAddress(customerAddressModel: customerAddressModel, completion: { data, response, error in
            print(response ?? "")
        })
    }
    
    func callNetworkServiceToPutAddress(customerAddressModel : CustomerAddressModel){
        NetworkService.shared.putAddress(customerAddressModel: customerAddressModel, completion: { data, response, error in
            print(response ?? "")
        })
    }
    
    func callNetworkServiceToGetAddress(url : String?,compilation : @escaping (CustomerAddressGetModel)->()){
        NetworkService.shared.fetchData(url: url) { result in
            NetworkServiceManager.addresses = result
        }
    }
}
