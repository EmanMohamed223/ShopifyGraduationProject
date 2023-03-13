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
    func postAddress(customerAddressModel : CustomerAddressModel,completion: @escaping (Data?, HTTPURLResponse?, Error?) -> ())
    
     func postDataToApi(url : String ,newOrder: [String : Any],completion: @escaping (HTTPURLResponse?) -> ())
}

class NetworkService : Service{
    
    //let productDet = ProductDetailsViewController()
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

    
    func putAddress(customerAddressModel : CustomerAddressModel,completion: @escaping (Data?, HTTPURLResponse?, Error?) -> ()) {

        let userID = UserDefaultsManager.shared.getUserID()
        let addressId = customerAddressModel.customer_address?.id
        let url = getURL(endPoint: "customers/\(userID ?? 0)/addresses/\(addressId ?? 0).json")
        guard let baseURL = URL(string : url ?? "") else { return }
        var request = URLRequest(url: baseURL)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        request.httpShouldHandleCookies = false

        do{
            let data = try JSONSerialization.data(withJSONObject: customerAddressModel.asDictionary(), options: .prettyPrinted)
            
            URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
                if let error = error {
                        print("Error making PUT request: \(error.localizedDescription)")
                        return
                    }

                if let responseCode = (response as? HTTPURLResponse)?.statusCode, let data = data {
                    guard responseCode == 200 else {
                        print("Invalid response code: \(responseCode)")
                        return
                    }

                    if let responseJSONData = try? JSONSerialization.jsonObject(with: data , options: .allowFragments) {
                        print("Response JSON data = \(responseJSONData)")
                    }
                }
                completion(data, response as? HTTPURLResponse, error)
            }.resume()
            print(try! customerAddressModel.asDictionary())
        } catch let error {
            print(error.localizedDescription)
        }


    }
    
    func putDraft(draftOrderModel : ShoppingCartResponse,completion: @escaping (Data?, HTTPURLResponse?, Error?) -> ()) {

        let draftOrder_id = UserDefaultsManager.shared.getDraftOrderID()! 
       // let draftOrderId = draftOrderModel.draft_order.id
        let url = getURL(endPoint: "draft_orders/\(draftOrder_id).json")
        guard let baseURL = URL(string : url ?? "") else { return }
        var request = URLRequest(url: baseURL)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        request.httpShouldHandleCookies = false

        do{
            let data = try JSONSerialization.data(withJSONObject: draftOrderModel.asDictionary(), options: .prettyPrinted)
            
            URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
                if let error = error {
                        print("Error making PUT request: \(error.localizedDescription)")
                        return
                    }

                if let responseCode = (response as? HTTPURLResponse)?.statusCode, let data = data {
                    guard responseCode == 200 else {
                        print("Invalid response code: \(responseCode)")
                        return
                    }

                    if let responseJSONData = try? JSONSerialization.jsonObject(with: data , options: .allowFragments) {
                        print("Response JSON data = \(responseJSONData)")
                    }
                }
                completion(data, response as? HTTPURLResponse, error)
            }.resume()
            print(try! draftOrderModel.asDictionary())
        } catch let error {
            print(error.localizedDescription)
        }


    }

     func postDataToApi(url : String ,newOrder: [String:Any], completion: @escaping (HTTPURLResponse?) -> ()) {
      
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newOrder, options: .prettyPrinted)
            print(newOrder)
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                let dataJson = try JSONSerialization.jsonObject(with: data! , options: .allowFragments)
                print("RESPONSEE")
                print(dataJson)
                completion(response as? HTTPURLResponse)
                //self.productDet.setdraftIdForPost()
            }catch{
                print("ERRRRR")
                print(error.localizedDescription)
                print(String(describing: error))
            }
        }.resume()
    }
    
    
    func postDraftOrder(url : String ,newOrder: [String:Any],completion: @escaping (Data?, HTTPURLResponse?, Error?) -> ()) {
     
       guard let url = URL(string: url) else { return }
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       request.httpShouldHandleCookies = false
       
       do {
           request.httpBody = try JSONSerialization.data(withJSONObject: newOrder, options: .prettyPrinted)
           print(newOrder)
       } catch let error {
           print(error.localizedDescription)
       }
       
       
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       request.addValue("application/json", forHTTPHeaderField: "Accept")
       
       URLSession.shared.dataTask(with: request) { (data, response, error) in
           do{
               let dataJson = try JSONSerialization.jsonObject(with: data! , options: .allowFragments)
               print(dataJson)
               completion(data,response as? HTTPURLResponse,error)
           }catch{
               print(error.localizedDescription)
               print(String(describing: error))
           }
       }.resume()
   }
    

    func postAddress(customerAddressModel : CustomerAddressModel,completion: @escaping (Data?, HTTPURLResponse?, Error?) -> ()){
        let userId = UserDefaultsManager.shared.getUserID()
        let urlStr =  getURL(endPoint: "customers/\(userId ?? 0)/addresses.json")
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
            completion(data, response as? HTTPURLResponse, error)
        }.resume()
    }
    
    func deleteAddress(customerAddressModel : CustomerAddressModel,completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        let userID = UserDefaultsManager.shared.getUserID()
        let addressId = customerAddressModel.customer_address?.id
        let url = getURL(endPoint: "customers/\(userID ?? 0)/addresses/\(addressId ?? 0).json")
        guard let baseURL = URL(string : url ?? "") else { return }
        var request = URLRequest(url: baseURL)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        request.httpShouldHandleCookies = false

        do{
            URLSession.shared.dataTask(with: request) { data, response, error in
                        guard error == nil else {
                            print("Error: error calling DELETE")
                            print(error!)
                            return
                        }
                        guard let data = data else {
                            print("Error: Did not receive data")
                            return
                        }
                        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                            print(response)
                            print("Error: HTTP request failed")
                            return
                        }
                        do {
                            guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                                print("Error: Cannot convert data to JSON")
                                return
                            }
                            guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                                print("Error: Cannot convert JSON object to Pretty JSON data")
                                return
                            }
                            guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                                print("Error: Could print JSON in String")
                                return
                            }
                            
                            print(prettyPrintedJson)
                        } catch {
                            print("Error: Trying to convert JSON data to string")
                            return
                        }
                    }.resume()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    
    func deleteDraftOrder(url : String,completion: @escaping ( Error?) -> ()){
        let draftOrderID = UserDefaultsManager.shared.getDraftOrderID()
        let url = getURL(endPoint: "draft_orders/\(draftOrderID ?? 0).json")
        guard let baseURL = URL(string : url ?? "") else { return }
        var request = URLRequest(url: baseURL)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        request.httpShouldHandleCookies = false

        do{
            URLSession.shared.dataTask(with: request) { data, response, error in
                        guard error == nil else {
                            print("Error: error calling DELETE")
                            print(error!)
                            return
                        }
                        guard let data = data else {
                            print("Error: Did not receive data")
                            return
                        }
                        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                            print(response)
                            print("Error: HTTP request failed")
                            return
                        }
                        do {
                            guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                                print("Error: Cannot convert data to JSON")
                                return
                            }
                            guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                                print("Error: Cannot convert JSON object to Pretty JSON data")
                                return
                            }
                            guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                                print("Error: Could print JSON in String")
                                return
                            }
                            print("Draft order successfully deleted")
                            print(prettyPrintedJson)
                        } catch {
                            print("Error: Trying to convert JSON data to string")
                            return
                        }
                    }.resume()
        } catch let error {
            print(error.localizedDescription)
        }
        
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
    
    
//    func addToDraftOrder(newDraft: DraftOrder, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        let urlStr =  "https://55d695e8a36c98166e0ffaaa143489f9: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@ios-q2-new-capital-2022-2023.myshopify.com/admin/api/2023-01/draft_orders.json"
//        guard let url = URL(string: urlStr) else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpShouldHandleCookies = false
//        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: newDraft.asDictionary(), options: .prettyPrinted)
//            print(try! newDraft.asDictionary())
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        
//        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            completion(data, response, error)
//        }.resume()
//    }
    
}
