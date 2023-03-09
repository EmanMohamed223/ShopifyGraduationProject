//
//  PaymentViewController.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 21/02/2023.
//

import UIKit
import SnackBar_swift

class PaymentViewController: UIViewController {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var shippingFeesLabel: UILabel!
    @IBOutlet weak var couponTxtField: UITextField!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var grandTotalLabel: UILabel!   
    @IBOutlet weak var validate : UIButton!
    
    var address : Customer_address?
    var price = 0
    var subTotal = 0
    static var lineItems : [LineItem]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        couponTxtField.text = UIPasteboard.general.string
        countryLabel.text = address?.country
        cityLabel.text = address?.city
        streetLabel.text = address?.address1
        shippingFeesLabel.text = String(15)
        
        //phoneLabel.text = UserDefaultsManager.shared.getUserPhoneNumber()
        
    }
    
    @IBAction func validateBtn(_ sender: Any) {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            indicator.stopAnimating()
        }
        if couponTxtField.text != nil && !UserDefaults.standard.bool(forKey: "coupon"){
            UserDefaults.standard.set(true, forKey: "coupon")
            validate.backgroundColor = UIColor(named: "gray")
            validate.setTitle("validated", for: .selected)
            SnackBar.make(in: self.view, message: "Congratulations, coupon succesuflly validated!", duration: .lengthLong).show()
        }
        else{
            //validate.backgroundColor = UIColor(named: "gray")
        }
    }
    
    @IBAction func placeOrderBtn(_ sender: Any) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "paymentOperation") as? PaymentOperationViewController
        view?.prices = Price()
        view?.prices = getPrices()
        view?.address = getCustomerAddress()
        view?.lineItems = PaymentViewController.lineItems
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
  

}

extension PaymentViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.size.width
                , height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PaymentViewController.lineItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PaymentCollectionViewCell
        cell.itemName.adjustsFontSizeToFitWidth = true
        cell.itemName.text = PaymentViewController.lineItems?[indexPath.row].title
        cell.itemPrice.text = PaymentViewController.lineItems?[indexPath.row].price
        price = Int(cell.itemPrice.text ?? "") ?? 0
        subTotal += price
        subTotalLabel.text = (subTotal).formatted()
        cell.numOfItemsPerProduct.text = (PaymentViewController.lineItems?[indexPath.row].quantity)?.formatted()
        
        return cell
    }
    
    func getPrices() -> Price?{
        return Price(current_subtotal_price: subTotalLabel.text, current_total_discounts: discountLabel.text, current_total_price: grandTotalLabel.text)
    }
    
    func getCustomerAddress() -> Customer_address?{
        return address
    }
}
