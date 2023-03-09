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
    @IBOutlet weak var validationLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var address : Customer_address?
    var price = 0
    var subTotal = 0
    var currency : String!
    static var lineItems : [LineItem]?
    static var subTotal : Float?
    var grandTotal : Float!
    var shippingFees : Float = 15
    var discountCodeViewModel : DiscountCodeViewModel!
    var discountCodeUrl : String!
    var discountCodes : [DiscountCode]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        grandTotal = 0
        currency = UserDefaultsManager.shared.getCurrency() ?? "EGP"
        couponTxtField.text = UIPasteboard.general.string
        countryLabel.text = address?.country
        cityLabel.text = address?.city
        streetLabel.text = address?.address1
        shippingFeesLabel.text = String("15 \(currency!)")
        subTotalLabel.text = String(format: "%.2f \(currency!)", PaymentViewController.subTotal ?? 0)
        grandTotalLabel.text = String(format: "%.2f \(currency!)", calcGrandTotal())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.discountCodeUrl = getURL(endPoint: "price_rules/1377368047897/discount_codes.json")
        self.discountCodeViewModel = DiscountCodeViewModel()
        self.discountCodeViewModel.getPriceRules(url: self.discountCodeUrl)
        self.discountCodeViewModel.bindResultToViewController = {
            self.renderPriceRules(discountCodes: self.discountCodeViewModel.discountCodeResponse.discount_codes)
        }
    }
    
    @IBAction func validateBtn(_ sender: Any) {
        
        if couponTxtField.text != nil && !UserDefaults.standard.bool(forKey: "coupon"){
            for index in 0...(discountCodes?.count ?? 0){
                if couponTxtField.text == discountCodes?[index].code{
                    let indicator = UIActivityIndicatorView(style: .large)
                    indicator.center = view.center
                    view.addSubview(indicator)
                    indicator.startAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        indicator.stopAnimating()
                    }
                    UserDefaults.standard.set(true, forKey: "coupon")
                    validate.backgroundColor = UIColor(named: "gray")
                    validate.setTitle("validated", for: .selected)
                    validationLabel.text = ""
                    discountLabel.text = String("30 \(currency)")
                    SnackBar.make(in: self.view, message: "Congratulations, coupon succesuflly validated!", duration: .lengthLong).show()
                    discountLabel.text = String("-30 \(currency)")
                    grandTotalLabel.text = String(format: "%.2f", calcGrandTotal())
                }
            }
        }
        else if couponTxtField.text == ""{
            validationLabel.text = "Enter the coupon code"
        }
        else{
            validationLabel.text = "Coupon is already used"
        }
    }
    
    @IBAction func placeOrderBtn(_ sender: Any) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "paymentOperation") as? PaymentOperationViewController
        vc?.prices = Price()
        vc?.prices = getPrices()
        vc?.address = getCustomerAddress()
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
        cell.itemImage.kf.setImage(with: URL(string: PaymentViewController.lineItems?[indexPath.row].sku ?? "load"),placeholder: UIImage(named: "load"))
        price = Int(cell.itemPrice.text ?? "") ?? 0
        subTotal += price
        //subTotalLabel.text = (subTotal).formatted()
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


extension PaymentViewController{
    func renderPriceRules(discountCodes : [DiscountCode]?){
        guard let discountCodes = discountCodes else { return}
        self.discountCodes = discountCodes
    }
    
    func calcGrandTotal() -> Float{
        let subTotal = PaymentViewController.subTotal ?? 0.0
        grandTotal += shippingFees + subTotal
        return grandTotal
    }
}
