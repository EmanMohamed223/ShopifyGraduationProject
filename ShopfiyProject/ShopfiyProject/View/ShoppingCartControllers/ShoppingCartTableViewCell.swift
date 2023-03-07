//
//  ShoppingCartTableViewCell.swift
//  ShopifyProj
//
//  Created by Mariam Moataz on 20/02/2023.
//

import UIKit
import Kingfisher

class ShoppingCartTableViewCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var numOfItems: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productTitle.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    @IBAction func increaseBtn(_ sender: Any) {
            /*if numOfItems < product.numOfItems{
                numOfItems--
        }*/
        var num = Int(numOfItems.text ?? "")!
        if num < 5{
            num += 1
            numOfItems.text = String(num)
        }
    }
    
    @IBAction func decreaseBtn(_ sender: Any) {
        /*if numOfItems > 0{
            numOfItems--
            if numOfItems == 0{
                let alert = UIAlertController(title: "Remove Product", message: "Are you sure you want to remove this product from the cart?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default){_ in
                    //remove product logic
                })
                alert.addAction(UIAlertAction(title: "No", style: .default){_ in
                    //numOfItems++
                })
                self.present(alert, animated: true)
            }
        }*/
        var num = Int(numOfItems.text ?? "")!
        if num > 1{
            num -= 1
            numOfItems.text = String(num)
        }
    }
    
}
