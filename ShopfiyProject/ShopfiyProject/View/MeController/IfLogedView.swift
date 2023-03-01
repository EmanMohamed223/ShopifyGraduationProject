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
   
    
}
