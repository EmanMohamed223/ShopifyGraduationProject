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
   
    @IBAction func signInBtm(_ sender: Any) {
        delegate!.navigateToSignIn()
       
    }
    
    
    @IBAction func signUpBtm(_ sender: UIButton) {
        delegate!.navigateToSignup()
    }

}
