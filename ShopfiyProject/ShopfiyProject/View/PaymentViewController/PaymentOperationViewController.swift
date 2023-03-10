//
//  PaymentOperationViewController.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 26/02/2023.
//

import UIKit
import PassKit
import Braintree
import BraintreeDropIn

class PaymentOperationViewController: UIViewController {
    
    @IBOutlet weak var paymentSegment: UISegmentedControl!
    
   let authorization = "sandbox_8h5229nh_jpbyz2k4fnvh6fvt"
    var paymentViewModel = PaymentViewModel()
    var paymentRequest = PKPaymentRequest()

    var braintreeClient: BTAPIClient!
    var arrayOrders : [Order] = []

    
 var braintreeClient: BTAPIClient!
    var arrayOrders : Orders?

    var orderVm : orderViewModel?
    static var lineItems : [LineItem]?
    var prices : Price?
    var address : Customer_address?
    var newOrder : [String : Any]?
     override func viewDidLoad() {
        super.viewDidLoad()
         PaymentOperationViewController.lineItems = PaymentViewController.lineItems
    }
    
    func startCheckout(){//sandbox_zjkyng8w_jpbyz2k4fnvh6fvt

        if paymentSegment.selectedSegmentIndex == 0{
            postOrder()
            let alert = UIAlertController(title: "Ordered Successfully", message: "The order will be arrived soon!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default){_ in
            })
            self.present(alert, animated: true)
        }
        else{
            braintreeClient = BTAPIClient(authorization: "sandbox_q7ftqr99_7h4b4rgjq3fptm87")//<<<mk
            let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
            let request = BTPayPalCheckoutRequest(amount: "2.32")
            request.currencyCode = UserDefaultsManager.shared.getCurrency() ?? "USD"
            payPalDriver.tokenizePayPalAccount(with: request) { responseNonce, error in
                if responseNonce != nil {
                    self.postOrder()
                }
                else if error != nil{
                    print("Error :\(error!)")
                }

            }
        }
    }
    
    
    @IBAction func payBtn(_ sender: UIButton) {
       
       startCheckout()
        
    }
    
    func renderPaymentRequest(request : PKPaymentRequest?){
        self.paymentRequest = request ?? PKPaymentRequest()
    }
    
    func postOrder(){
   print("/////////////")
//        "current_subtotal_price": prices?.current_subtotal_price ?? "0.0",
//        "current_total_discounts": prices?.current_total_discounts ?? "0.0" ,
//        "current_total_price": prices?.current_total_price ?? "0.0",
      orderVm = orderViewModel()
//        newOrder = [
//     "orders" : [
//
//        "contact_email": "asmmmmaaaa",
//            "currency": "EGP",
//            "order_status_url" : "asmaaaa....com",
//            "email" : "sob@gmail.com",
//
//            "line_items" : [[
//            "fulfillable_quantity" : 5,
//            "fulfillment_service":"manual",
//            "fulfillment_status":"null",
//            "name": "shhh",
//            "price": "0.10",
//            "quantity" : 3,
//            "sku" :  "women",
//            "title" :  "shoes",
//
//            "admin_graphql_api_id":"adminn",
//         //   "gift_card":false,
//            "current_subtotal_price":  "250.0",
// //            "current_total_discounts":"250.0" ,
// //            "current_total_price": "250.0",
//             //"number" : 2 ,
//             //"order_number" : 123 ,
//             //"id" : 123654789, // "confirmed" : true ,
//             //  "source_url":"null",
//             // "source_identifier":"null",
//            "grams":0,
//            "product_id":1542,
//            "total_discount":"0.00",
//           // "product_exists":false,
//
//            //"requires_shipping":true,
//         //   "taxable":true,
//
//
//       //     "variant_id":145,
//            //"variant_inventory_management":"null",
//            //"variant_title":"null",
//           // "vendor":"null",
//                 ]],
//        "token":"0bd8c8389cdd56c3f6b6e61671539556",
//        "payment_terms":"cash",
//        "total_discounts":"0.00",
//        "updated_at":"2023-03-09T07:55:26-05:00",
//
//        "source_name":"29080387585",
//        "presentment_currency":"USD",
//        "gateway":"25.314.26",
//          //  "landing_site":"null",
//           // "landing_site_ref":"null",
//           // "location_id":1025,
////            "customer":[
////                     "email":"mariam@gmail.com",
////                //     "accepts_marketing":false,
////                     "first_name":"mariam223",
////                    // "last_name":"null",
////                     "state":"disabled",
////                    // "note":"null",
////                   //  "verified_email":true,
////                     "multipass_identifier":"null",
////                  //   "tax_exempt":false,
////                     "tags":"1234567890",
////                     "currency":"EGP",
////                   //  "phone":"null",
////                     "accepts_marketing_updated_at":"2023-03-04T17:53:15-05:00",
////                     "admin_graphql_api_id":"ffffff",
////                     "default_address":[
////                        "first_name":"mariam223",
////                       // "last_name":"null",
////                       // "company":"null",
////                        "address1":"Desert",
////                       // "address2":"null",
////                        "city":"Giza",
////                     //   "province":"null",
////                        "country":"Egypt",
////                       // "zip":"null",
////                       // "phone":"null",
////                        "name":"mariam223",
////                     //   "province_code":"null",
////                        "country_code":"EG",
////                        "country_name":"Egypt",
////                     ]
////                  ]
//     ]]
//
//                orderVm?.postOrder(order: newOrder!)
     print("////////////")
            print(prices?.current_subtotal_price ?? "0.0")
        print( prices?.current_total_discounts ?? "0.0")
        print(prices?.current_total_price ?? "0.0")
        let newOrder : Order = Order(admin_graphql_api_id : "" , contact_email:  UserDefaultsManager.shared.getUserEmail()!,
                                        email: UserDefaultsManager.shared.getUserEmail()!, created_at: "2023-15-3",
                                      currency: UserDefaultsManager.shared.getCurrency() ?? "EGP", current_subtotal_price: prices?.current_subtotal_price ?? "250",
                                        current_total_discounts: prices?.current_total_discounts ?? "250" ,
                                        current_total_price: prices?.current_total_price ?? "250" ,line_items : PaymentViewController.lineItems ?? [] )
        arrayOrders.append(newOrder)
        let order  : Orderrs = Orderrs( order: arrayOrders  )

        orderVm?.putOrder(newOrder: order)
            }
}


extension PaymentOperationViewController : PKPaymentAuthorizationViewControllerDelegate{
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true,completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
}

extension PaymentOperationViewController : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }

    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

}
