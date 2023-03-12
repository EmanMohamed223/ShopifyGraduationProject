//
//  ProductTableViewCell.swift
//  ShopfiyProject
//
//  Created by Eman on 22/02/2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productRateLabel: UILabel!
    
    
    @IBOutlet weak var productColor: UILabel!
    
    @IBOutlet weak var productSize: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
