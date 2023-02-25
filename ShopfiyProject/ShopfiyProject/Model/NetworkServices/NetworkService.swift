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
    
    
    
    
    
    //eman
    func register(newCustomer: User, completion:@escaping (Data?, URLResponse?, Error?)->())
    
    //func getCustomers(email: String, complition: @escaping ([Customer]?, Error?)->Void)
    
    
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
    
    
    
    
    
    //eman
    func register(newCustomer: User, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let urlStr =  ""
        guard let url = URL(string: urlStr) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newCustomer, options: .prettyPrinted)
            // print(try! newCustomer)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
    
//
//
//    func convertFromJson<T: Codable>(data: Data) -> T? {
//        let jsonDecoder = JSONDecoder()
//        let decodedjson = try? jsonDecoder.decode(T.self, from: data)
//        return decodedjson
//    }
//
//    func getCustomers(email: String, complition: @escaping ([Customer]?, Error?)->Void) {
//        let urlStr = ""
//        guard let url = URL(string: urlStr) else { return }
//
//        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { response in
//            if let error = response.error {
//                complition(nil, error)
//            }
//
//            guard let urlResponse = response.response else {return}
//            if !(200..<300).contains(urlResponse.statusCode) {
//                print("error in status code")
//            }
//
//            guard let data = response.data else { return }
//
//            let decodedJson: CustomerResponse = convertFromJson(data: data) ?? CustomerResponse(customers: [Customer]())
//            complition(decodedJson.customers, nil)
//            print("customer retreived")
//        }
//    }

}
