//
//  EditAddressProtocol.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 04/03/2023.
//

import Foundation

protocol EditAddressProtocol{
    func callNetworkServiceToPutAddress(customerAddressModel : CustomerAddressModel, completion: @escaping (HTTPURLResponse?)->())
}
