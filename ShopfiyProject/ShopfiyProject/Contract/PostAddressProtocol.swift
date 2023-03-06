//
//  PostAddressProtocol.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 04/03/2023.
//

import Foundation

protocol PostAddressProtocol{
    func callNetworkServiceToPostAddress(customerAddressModel : CustomerAddressModel,completion: @escaping (HTTPURLResponse?)->())    
}
