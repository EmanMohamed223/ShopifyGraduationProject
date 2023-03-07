//
//  FetchFromCoreProtocol.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 06/03/2023.
//

import Foundation

protocol FetchFromCoreProtocol{
    func fetchCoreData(appDelegate: AppDelegate, userID : Int) -> [Products]?
}
