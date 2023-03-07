//
//  EditDraftOrderProtocol.swift
//  ShopfiyProject
//
//  Created by Eman on 07/03/2023.
//

import Foundation
protocol EditDraftOrderProtocol{
    func callNetworkServiceToPutDraftOrder(draftOrder : ShoppingCartResponse, completion: @escaping (HTTPURLResponse?)->())
}
