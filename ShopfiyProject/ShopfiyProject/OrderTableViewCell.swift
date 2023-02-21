//
//  OrderTableViewCell.swift
//  ShopfiyProject
//
//  Created by Eman on 21/02/2023.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var pricelabel: UILabel!
    
    
    @IBOutlet weak var dateOfOrderlabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
