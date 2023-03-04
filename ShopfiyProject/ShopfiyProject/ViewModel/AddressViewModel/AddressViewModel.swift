//
//  AddressViewModel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 04/03/2023.
//

import Foundation

class AddressViewModel{
    
    var bindResultToViewController : (()->()) = {}
    
    var resultArray : [Customer_address]! {
        didSet{
            bindResultToViewController()
        }
    }
    
    var resultModel : CustomerAddressGetModel! {
        didSet{
            //resultArray = resultModel.addresses
            bindResultToViewController()

        }
    }
    
    func callNetworkServiceManagerForPost(customerAddressModel : CustomerAddressModel){
        NetworkServiceManager.shared.callNetworkServiceToPostAddress(customerAddressModel : customerAddressModel)
    }
    
    func callNetworkServiceManagerTorGetAddresses(url : String?){
//        NetworkServiceManager.shared.callNetworkServiceToGetAddress(url: url) { _ in
//            self.resultModel = NetworkServiceManager.addresses
//        }
        NetworkService.shared.fetchData(url: url) { result in
            self.resultModel = result
        }
    }
}