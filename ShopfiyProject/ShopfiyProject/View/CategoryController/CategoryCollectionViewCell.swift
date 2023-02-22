//
//  CategoryCollectionViewCell.swift
//  ShopfiyProject
//
//  Created by Asmaa_Abdelfattah on 01/12/1401 AP.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryPrice: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var CategoryImage: UIImageView!
    var select: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func selectFavourie(_ sender: Any) {
        if(select == 0){
            categoryButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            select += 1
        }
        else{
            categoryButton.setImage(UIImage(systemName: "heart"), for: .normal)
            select = 0
        }
    }
}
