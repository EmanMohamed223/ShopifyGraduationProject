//
//  ShoppingCartTableViewCell.swift
//  ShopifyProj
//
//  Created by Mariam Moataz on 20/02/2023.
//

import UIKit
import Kingfisher
import SnackBar_swift

class ShoppingCartTableViewCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var numOfItems: UILabel!
    
    var delegate : ShoppingCartDelegate?
    
    var lineItem : LineItem?
    var view : UIView = UIView()
    var viewVC : UIViewController = UIViewController()
    var num = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productTitle.adjustsFontSizeToFitWidth = true
        //num = Int(numOfItems.text ?? "") ?? 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    @IBAction func increaseBtn(_ sender: Any) {
        if num < 5{ //Replace the static with lineItem?.grams  <<<<<<<<<<<<<<<<
            num += 1
            numOfItems.text = String(num)
            delegate?.calcSubTotalInc(price: productPrice.text ?? "")
        }
        else{
            SnackBar.make(in: self.view, message: "Maximum items in the store", duration: .lengthLong).setAction(with: "Close", action: nil).show()
        }
    }
    
    @IBAction func decreaseBtn(_ sender: Any) {
        if num >= 2{
            num -= 1
            numOfItems.text = String(num)
            delegate?.calcSubTotalDec(price: productPrice.text ?? "")
        }
        else{
            let alert = UIAlertController(title: "Remove Product", message: "If you want to delete this item just swipe it!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default){_ in
            })
            self.viewVC.present(alert, animated: true)
        }
    }
    
}

//extension ShoppingCartTableViewCell : ShoppingCartDelegate{
//    func increaseNumberOfItems() -> (Int)? {
//        return 5
//    }
//    
//    func decreaseNumberOfItems() -> (Int)? {
//        return 5
//    }
//    
//    
//}
