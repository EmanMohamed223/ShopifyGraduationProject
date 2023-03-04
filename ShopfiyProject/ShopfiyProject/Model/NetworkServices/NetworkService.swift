//
//  NetworkService.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 04/12/1401 AP.
//

import Foundation
import Alamofire


protocol Service{
    func fetchData <T : Decodable>(url:String?,compiletionHandler : @escaping (T?)->Void)
    func register(newCustomer: User, completion:@escaping (Data?, URLResponse?, Error?)->())
    func postAddress(customerAddressModel : CustomerAddressModel,completion: @escaping (Data?, URLResponse?, Error?) -> ())
    
}

class NetworkService : Service{
    
    static let shared = NetworkService()
    private init(){}
    
    func fetchData<T>(url: String?, compiletionHandler: @escaping (T?) -> Void) where T : Decodable {
        
        let request = AF.request(url ?? "")
        
        request.responseDecodable(of:T.self) { (response) in
            guard let APIResult = response.value else {
                
                compiletionHandler(nil)
                return }
            
            compiletionHandler(APIResult)
        }
    }
    
    func postAddress(customerAddressModel : CustomerAddressModel,completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        
        let urlStr =  getURL(endPoint: "customers/6858983276825/addresses.json")
        guard let url = URL(string: urlStr!) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: customerAddressModel.asDictionary(), options: .prettyPrinted)
            print(try! customerAddressModel.asDictionary())
        } catch let error {
            print(error.localizedDescription)
        }        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
        
//        let params: Parameters = [
//            //"customer_address.customer_id" : UserDefaultsManager.shared.getUserID() ?? 0,
//            "customer_address.customer_id" : customerId,
//            "customer_address.address1" : address.street ?? " ",
//            "customer_address.city" : address.city ?? " ",
//            "customer_address.country" : address.country ?? " "
//        ]
//        let url = "https://55d695e8a36c98166e0ffaaa143489f9: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@ios-q2-new-capital-2022-2023.myshopify.com/admin/api/2023-01/customers/\(customerId)/addresses.json"
//        AF.request(url,method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
//
//            switch response.result{
//            case .success():
//                do{
////                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
////                            print("Error: Cannot convert data to JSON object")
////                            return
////                        }
//                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: address.asDictionary(), options: .prettyPrinted) else {
//                            print("Error: Cannot convert JSON object to Pretty JSON data")
//                            return
//                        }
//                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                            print("Error: Could print JSON in String")
//                            return
//                        }
//
//                        print(prettyPrintedJson)
//                }
//                catch {
//                            print("Error: Trying to convert JSON data to string")
//                            return
//                        }
//                    case .failure(let error):
//                        print(error)
//            }
//        }
    }
    
    
    
    //eman
    func register(newCustomer: User, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let urlStr =  getURL(endPoint: "customers.json")
        guard let url = URL(string: urlStr!) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newCustomer.asDictionary(), options: .prettyPrinted)
            print(try! newCustomer.asDictionary())
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    



    
//    func postMethod(shopingCard :ShoppingCart) {
//        let params: Parameters =
//
//        AF.request("https://55d695e8a36c98166e0ffaaa143489f9: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@ios-q2-new-capital-2022-2023.myshopify.com/admin/api/2023-01/draft_orders.json", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
//            switch response.result {
//                case .success(let data):
//                    do {
//                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                            print("Error: Cannot convert data to JSON object")
//                            return
//                        }
//                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//                            print("Error: Cannot convert JSON object to Pretty JSON data")
//                            return
//                        }
//                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                            print("Error: Could print JSON in String")
//                            return
//                        }
//
//                        print(prettyPrintedJson)
//                    } catch {
//                        print("Error: Trying to convert JSON data to string")
//                        return
//                    }
//                case .failure(let error):
//                    print(error)
//            }
//        }
//    }
    
    
    func addToDraftOrder(newDraft: DraftOrder, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let urlStr =  "https://55d695e8a36c98166e0ffaaa143489f9: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@ios-q2-new-capital-2022-2023.myshopify.com/admin/api/2023-01/draft_orders.json"
        guard let url = URL(string: urlStr) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newDraft.asDictionary(), options: .prettyPrinted)
            print(try! newDraft.asDictionary())
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
}
