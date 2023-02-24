//
//  NetworkService.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 04/12/1401 AP.
//

import Foundation
import Alamofire
protocol Service{
    static func fetchData <T : Decodable>(url:String?,compiletionHandler : @escaping (T?)->Void)
}

class NetworkService : Service {
    static func fetchData<T>(url: String?, compiletionHandler: @escaping (T?) -> Void) where T : Decodable {
 
        let request = AF.request(url ?? "")
        
        request.responseDecodable(of:T.self) { (response) in
            guard let APIResult = response.value else {

                compiletionHandler(nil)
              return }

        compiletionHandler(APIResult)
        }
    }
    
    
}
