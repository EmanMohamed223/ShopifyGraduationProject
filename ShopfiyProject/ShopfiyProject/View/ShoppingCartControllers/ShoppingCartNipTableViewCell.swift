//
//  ShoppingCartNipTableViewCell.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 22/02/2023.
//

import UIKit

class ShoppingCartNipTableViewCell: UITableViewCell {

    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNumItems: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func decreaseBtn(_ sender: Any) {
    }
    
    @IBAction func increaseBtn(_ sender: Any) {
    }
    
}
