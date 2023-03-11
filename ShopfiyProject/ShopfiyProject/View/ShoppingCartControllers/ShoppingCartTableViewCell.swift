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
    @IBOutlet weak var currencyLabel: UILabel!
    
    var delegate : ShoppingCartDelegate?
    var viewModelProduct = ViewModelProduct()
    
    var view : UIView = UIView()
    var viewVC : UIViewController = UIViewController()
    var tableVC : UITableView = UITableView()
    
    var lineItems : [LineItem] = []
    var num = 1
    var indexPath : IndexPath  = IndexPath(row: 0, section: 0)
    var priceQ : [Int : Int] = [:]
    
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
            delegate?.calcSubTotalDec(price: productPrice.text ?? "")
        }
        else{
            let alert = UIAlertController(title: "Remove Product", message: "If you want to delete this item click on the trash icon or just swipe it!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default){_ in
            })
            self.viewVC.present(alert, animated: true)
        }
    }
    
    
    
    @IBAction func trashBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Remove Product", message: "Are you sure you want ot delete this product?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default){_ in
            self.lineItems.remove(at: self.indexPath.row)
            let updatedLineItems = ShoppingCartClass(line_items: self.lineItems)
            let draftOrder = ShoppingCartResponse(draft_order: updatedLineItems)
            self.viewModelProduct.callNetworkServiceManagerToPut(draftOrder: draftOrder) { response in
                if response.statusCode >= 200 && response.statusCode <= 299{
                    DispatchQueue.main.async {
                        
                        self.tableVC.deleteRows(at: [self.indexPath], with: UITableView.RowAnimation.automatic)
                        self.delegate?.calcSubTotalInc()
                    }
                }
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .default){_ in
        })
        self.viewVC.present(alert, animated: true)
    }
    
}
