//
//  View.swift
//  ShopfiyProject
//
//  Created by Eman on 22/02/2023.
//

import UIKit

class View: UIView {
    var delegate : Navigationdelegate?
    @IBOutlet weak var guestImg: UIImageView!
    
var me = MeViewController()
    
    @IBAction func signInBtm(_ sender: Any) {
      //  me.navigateToSignIn()
    }
    
    
    @IBAction func signUpBtm(_ sender: UIButton) {
       // me.navigateToSignup()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
