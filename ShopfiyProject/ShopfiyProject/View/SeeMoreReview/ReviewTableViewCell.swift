//
//  ReviewTableViewCell.swift
//  ShopfiyProject
//
//  Created by Eman on 20/02/2023.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviwerLabel: UILabel!
    
    @IBOutlet weak var reviewLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
