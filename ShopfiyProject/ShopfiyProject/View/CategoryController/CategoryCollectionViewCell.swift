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
  
    var  isFav : Bool?
    var isInFavController : Bool?
    var product : Products?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

  var  favouriteDelegate : FireActionInCategoryCellFavourite?
  var  productDelegate : FireActionInCategoryCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
    }

    @IBAction func selectFavourie(_ sender: Any) {
        if isInFavController! {
            actionTakenInFavouritesController()
        } else {
            actionTakenInProductsController()
        }
    }
    
    func checkFavourite (isFav : Bool  , product : Products , isInFavController : Bool=false)
    {
        if isFav {
            categoryButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            categoryButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        self.isFav = isFav
        self.isInFavController = isInFavController
        self.product = product
    }
    
    
    func actionTakenInProductsController() {
        if !UserDefaultsManager.shared.getUserStatus() {
            productDelegate!.showAlert(title: "Alert",message: "You must login")
            return
        }
        
        if isFav! {
            productDelegate!.deleteFavourite(appDelegate: appDelegate, product: product!)
            categoryButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            product?.variants![0].id = UserDefaultsManager.shared.getUserID()!
            productDelegate!.addFavourite(appDelegate: appDelegate, product: product!)
            categoryButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        isFav = !isFav!
    }
    
    func actionTakenInFavouritesController() {
        favouriteDelegate?.deleteFavourite(appDelegate: appDelegate, product: product!)
    }
    
}

    
