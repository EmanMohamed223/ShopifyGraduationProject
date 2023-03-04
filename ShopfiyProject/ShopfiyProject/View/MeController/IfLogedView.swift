//
//  IfLogedView.swift
//  ShopfiyProject
//
//  Created by Eman on 22/02/2023.
//

import UIKit

class IfLogedView: UIView {
    var delegate : Navigationdelegate?
    @IBOutlet weak var orderOnePrice: UILabel!
    
    @IBOutlet weak var orderOneDate: UILabel!
    
    @IBOutlet weak var orderTwoPricce: UILabel!
    
    
    @IBOutlet weak var orderTwoDate: UILabel!
    
    
    
    @IBOutlet weak var favImg1: UIImageView!
    
    @IBOutlet weak var productname1: UILabel!
    
    @IBOutlet weak var favImg2: UIImageView!
    
    @IBOutlet weak var productname2: UILabel!
    
    @IBOutlet weak var favImg3: UIImageView!
    
    @IBOutlet weak var productname3: UILabel!
    
    @IBOutlet weak var favImg4: UIImageView!
    
    @IBOutlet weak var productname4: UILabel!
    
    @IBOutlet weak var welcomMsg: UILabel!
    
    @IBAction func moreWishList(_ sender: UIButton) {
        delegate?.Tapfavourite()
    }
    
    @IBAction func moreOrders(_ sender: UIButton) {
        delegate?.navigateToMoreOrders()
    }
    var favoritesArray = [Products]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var favoritesViewModel = FavoritesViewModel()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        favoritesViewModel.bindingData = { favourites, error in
            if let favourites = favourites {
                self.favoritesArray = favourites
            }
            
            if let error = error {
                print(error.localizedDescription)
                
            }
        }
        favoritesViewModel.fetchfavorites(appDelegate: appDelegate, userId: UserDefaultsManager.shared.getUserID() ?? 1)
        
        switch (favoritesArray.count)
        {
        case 1 :
            self.configure_wishlistView (favName : productname1 , favImg : favImg1 , favNum : 0)
        case 2 :
            self.configure_wishlistView (favName : productname1 , favImg : favImg1 , favNum : 0)
            self.configure_wishlistView (favName : productname2 , favImg : favImg2 , favNum : 1)
        case 3 :
            self.configure_wishlistView (favName : productname1 , favImg : favImg1 , favNum : 0)
            self.configure_wishlistView (favName : productname2 , favImg : favImg2 , favNum : 1)
            self.configure_wishlistView (favName : productname3 , favImg : favImg3 , favNum : 2)
        case 4 :
            self.configure_wishlistView (favName : productname1 , favImg : favImg1 , favNum : 0)
            self.configure_wishlistView (favName : productname2 , favImg : favImg2 , favNum : 1)
            self.configure_wishlistView (favName : productname3 , favImg : favImg3 , favNum : 2)
            self.configure_wishlistView (favName : productname4 , favImg : favImg4 , favNum : 3)
        case 0 :
            break
        default:
            self.configure_wishlistView (favName : productname1 , favImg : favImg1 , favNum : 0)
            self.configure_wishlistView (favName : productname2 , favImg : favImg2 , favNum : 1)
            self.configure_wishlistView (favName : productname3 , favImg : favImg3 , favNum : 2)
            self.configure_wishlistView (favName : productname4 , favImg : favImg4 , favNum : 3)
        }
            
        
        
        
        
    }
    func configure_wishlistView (favName : UILabel , favImg : UIImageView , favNum : Int) {
        
        favName.text = favoritesArray[favNum].title
        favImg.kf.setImage(with: URL(string: favoritesArray[favNum].images[0].src ?? "No image"), placeholder: UIImage(named: "none.png"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
    }
    
    
    
    
    
    
    
    
    
    
    }
