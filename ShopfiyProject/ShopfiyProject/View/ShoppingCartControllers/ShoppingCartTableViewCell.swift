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
    
    var lineItem : LineItem?
    var view : UIView = UIView()
    var viewVC : UIViewController = UIViewController()
    var num : Int!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productTitle.adjustsFontSizeToFitWidth = true
        num = Int(numOfItems.text ?? "") ?? 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    @IBAction func increaseBtn(_ sender: Any) {
        if num < lineItem?.grams ?? 0{
            num += 1
            numOfItems.text = String(num)
        }
        else{
            SnackBar.make(in: self.view, message: "Maximum items in the store", duration: .lengthLong).setAction(with: "Close", action: nil).show()
        }
    }
    
    @IBAction func decreaseBtn(_ sender: Any) {
        if num > 2{
            num -= 1
            numOfItems.text = String(num)
        }
        else{
            let alert = UIAlertController(title: "Remove Product", message: "Are you sure you want to remove this product from the cart?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default){_ in
                //remove product logic
            })
            alert.addAction(UIAlertAction(title: "No", style: .default){_ in
                //numOfItems++
            })
            self.viewVC.present(alert, animated: true)
        }
    }
    
}

extension ShoppingCartTableViewCell : ShoppingCartDelegate{
    func increaseNumberOfItems() -> (Int)? {
        return 5
    }
    
    func decreaseNumberOfItems() -> (Int)? {
        return 5
    }
    
    
}
