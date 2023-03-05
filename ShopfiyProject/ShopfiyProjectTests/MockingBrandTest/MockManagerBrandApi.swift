//
//  MockManagerBrandApi.swift
//  ShopfiyProjectTests
//
//  Created by Asmaa_Abdelfattah on 14/12/1401 AP.
//

import Foundation
@testable import ShopfiyProject
class MockNetworkManagerBrand{
    let mockNTManagerBrand : String =
    "{\"smart_collections\":[{\"id\":437786804505,\"handle\":\"vans\",\"title\":\"VANS\",\"updated_at\":\"2023-02-15T02:40:31-05:00\",\"body_html\":\"Vans collection\",\"published_at\":\"2023-02-15T02:34:19-05:00\",\"sort_order\":\"best-selling\",\"template_suffix\":null,\"disjunctive\":false,\"rules\":[{\"column\":\"title\",\"relation\":\"contains\",\"condition\":\"VANS\"}],\"published_scope\":\"web\",\"admin_graphql_api_id\":\"gid:\\/\\/shopify\\/Collection\\/437786804505\",\"image\":{\"created_at\":\"2023-02-15T02:34:19-05:00\",\"alt\":null,\"width\":1610,\"height\":805,\"src\":\"https:\\/\\/cdn.shopify.com\\/s\\/files\\/1\\/0721\\/3963\\/7017\\/collections\\/a340ce89e0298e52c438ae79591e3284.jpg?v=1676446459\"}}]}"

    func loadDataFromURL<T : Decodable>(url: String, compiletionHandler: @escaping (T?) -> Void) {
        let data = Data(mockNTManagerBrand.utf8)
        do {
            let response  = try JSONDecoder().decode(T.self, from: data)
            compiletionHandler(response)
        } catch {
            compiletionHandler(nil)
        }
    }
}
