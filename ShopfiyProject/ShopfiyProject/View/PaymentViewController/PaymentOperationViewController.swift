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
    var shoppingCartViewModel = ShoppingCartViewModel()
    
    
    @IBOutlet weak var grandTotalLabel: UILabel!
    @IBOutlet weak var currency: UILabel!
    
    
   let authorization = "sandbox_8h5229nh_jpbyz2k4fnvh6fvt"
    var paymentViewModel = PaymentViewModel()
    var paymentRequest = PKPaymentRequest()
//e
    var braintreeClient: BTAPIClient!
    var arrayOrders : [Order] = []


    var viewModel = CoreDataViewModel()

    var orderVm : orderViewModel?

    var lineItems : [LineItem]?
    
    static var grandTotal : String?
    static var lineItems : [LineItem]?

    static var prices : Price?
    var address : Customer_address?
   
     override func viewDidLoad() {
        super.viewDidLoad()
    
          lineItems = PaymentViewController.lineItems
         grandTotalLabel.text = Self.grandTotal
         currency.text = UserDefaultsManager.shared.getCurrency()
    }
    
    func startCheckout(){//sandbox_zjkyng8w_jpbyz2k4fnvh6fvt

        if paymentSegment.selectedSegmentIndex == 0{
            postOrder()
            let alert = UIAlertController(title: "Ordered Successfully", message: "The order will be arrived soon!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default){_ in
                let firstStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let homeVC = firstStoryBoard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
                self.navigationController?.pushViewController(homeVC, animated: true)
                
            })
            self.present(alert, animated: true)
        }
      else{

            braintreeClient = BTAPIClient(authorization: "sandbox_q7ftqr99_7h4b4rgjq3fptm87")//<<<mk
            let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
          let request = BTPayPalCheckoutRequest(amount: "\(Self.prices?.current_total_price ?? "")")
            //request.currencyCode = UserDefaultsManager.shared.getCurrency() ?? "USD"
          request.currencyCode = "USD"
            payPalDriver.tokenizePayPalAccount(with: request) { responseNonce, error in
                if responseNonce != nil {
                    DispatchQueue.main.async {
                        self.postOrder()
                        let firstStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                        let homeVC = firstStoryBoard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
                        self.navigationController?.pushViewController(homeVC, animated: true)
                    }

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
    
    func deleteDraftOrder(){
        let endpoint = UserDefaultsManager.shared.getDraftOrderID() ?? 0
        shoppingCartViewModel.deleteDraftOrder(url: getURL(endPoint: "\(endpoint)"))
    }
    
    
    func renderPaymentRequest(request : PKPaymentRequest?){
        //eman
      self.paymentRequest = request ?? PKPaymentRequest()
    }
    
    func postOrder(){
   print("/////////////")
//        print(Self.prices?.current_subtotal_price ?? "0.0")
//        print( Self.prices?.current_total_discounts ?? "0.0" )
//        print( Self.prices?.current_total_price ?? "0.0")
      orderVm = orderViewModel()

        let newOrder : [String : Any] = [
     "order" : [
            "confirmed" : true ,
            "contact_email" :  UserDefaultsManager.shared.getUserEmail() ?? "",
            "email" : UserDefaultsManager.shared.getUserEmail() ?? "" ,
            "currency": UserDefaultsManager.shared.getCurrency() ?? "EGP",
            "number" : 2 ,
            "order_status_url" : "asss",
            "current_subtotal_price": Self.prices?.current_subtotal_price ?? "0.0",
            "current_total_discounts": Self.prices?.current_total_discounts ?? "0.0" ,
            "current_total_price": Self.prices?.current_total_price ?? "0.0",
       
            "line_items" : convertter(lineItems: lineItems ?? [])
                ]
                ]
        
        NetworkService.shared.postDataToApi(url: getURL(endPoint: "orders.json")!, newOrder: newOrder) { response in
            guard let response = response else {return}
            if response.statusCode >= 200 && response.statusCode <= 299{
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    self.deleteDraftOrder()
                    self.viewModel.callManagerToDeleteAll(appDelegate: appDelegate, userID: UserDefaultsManager.shared.getUserID()!)
                    UserDefaultsManager.shared.setDraftOrderID(draftOrderID: nil)
                    UserDefaultsManager.shared.setDraftFlag(draftFlag: false)
                    UserDefaultsManager.shared.setCouponStatus(coupon: true)
                }
            }
        }


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
