//
//  ShoppingCartTableViewCell.swift
//  ShopifyProj
//
//  Created by Mariam Moataz on 20/02/2023.
//

import UIKit
import Kingfisher
import SnackBar_swift
import Reachability

class ShoppingCartTableViewCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var numOfItems: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var subBtn: UIButton!
    
    var delegate : ShoppingCartDelegate?
    var viewModelProduct = ViewModelProduct()
    
    var view : UIView = UIView()
    var viewVC : UIViewController = UIViewController()
    var tableVC : UITableView = UITableView()
    
    var lineItems : [LineItem] = []
    var num = 1
    var indexPath : IndexPath  = IndexPath(row: 0, section: 0)
    var priceQ : [Int : Int] = [:]
    var network : Reachability!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productTitle.adjustsFontSizeToFitWidth = true
        network = Reachability.forInternetConnection()
        if !network.isReachable(){
            addBtn.isEnabled = false
            subBtn.isEnabled = false
        }
        else{
            addBtn.isEnabled = true
            subBtn.isEnabled = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    @IBAction func increaseBtn(_ sender: Any) {
        if num < lineItems[indexPath.row].grams ?? 1{ //Replace the static with lineItem?.grams  <<<<<<<<<<<<<<<<
            num += 1
            numOfItems.text = String(num)
            lineItems[indexPath.row].quantity = num
            //delegate?.calcSubTotalInc(price: productPrice.text ?? "")
            delegate?.setLineItems(lineItem: lineItems[indexPath.row], index : indexPath.row )
            delegate?.calcSubTotalInc()
        }
        else{
            SnackBar.make(in: self.view, message: "Maximum items in the store", duration: .lengthLong).setAction(with: "Close", action: nil).show()
        }
    }
    
    @IBAction func decreaseBtn(_ sender: Any) {
        if num >= 2{
            num -= 1
            numOfItems.text = String(num)
            lineItems[indexPath.row].quantity = num
            delegate?.setLineItems(lineItem: lineItems[indexPath.row], index : indexPath.row)
            //delegate?.calcSubTotalDec(price: productPrice.text ?? "")
            delegate?.calcSubTotalDec(price: lineItems[indexPath.row].price ?? "")
        }
        else{
            let alert = UIAlertController(title: "Remove Product", message: "If you want to delete this item click on the trash icon or just swipe it!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default){_ in
            })
            self.viewVC.present(alert, animated: true)
        }
    }
    
    
    
    @IBAction func trashBtn(_ sender: Any) {
        self.delegate?.deleteFromCart(indexPath: indexPath)
    }
    
    func setNum(){
        print(indexPath.row)
        
        num = lineItems[indexPath.row].quantity ?? 1
    }
    
}
