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
    
    
    @IBOutlet weak var reviewerImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reviewerImg.layer.cornerRadius = reviewerImg.frame.width/2
        reviewerImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
