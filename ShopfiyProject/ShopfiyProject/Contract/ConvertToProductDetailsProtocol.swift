//
//  ConvertToProductDetailsProtocol.swift
//  ShopfiyProject
//
//  Created by Eman on 04/03/2023.
//

import Foundation
import CoreData

protocol ConvertToProductDetailsProtocol{
    func convertToProductFormatter(nsManagedObject : [NSManagedObject]) -> [Products]?
}

