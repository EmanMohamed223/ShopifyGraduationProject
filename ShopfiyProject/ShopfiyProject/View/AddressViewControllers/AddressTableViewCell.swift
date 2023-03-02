//
//  AddressTableViewCell.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 22/02/2023.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var streetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

