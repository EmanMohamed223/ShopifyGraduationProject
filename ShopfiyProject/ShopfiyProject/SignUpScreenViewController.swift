//
//  SignUpScreenViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 20/02/2023.
//

import UIKit

class SignUpScreenViewController: UIViewController {

    
    @IBOutlet weak var signupImg: UIImageView!
    
    
    @IBOutlet weak var usernameTxtfield: UITextField!
    
    @IBOutlet weak var emailTxtfield: UITextField!
    
    @IBOutlet weak var PassTextField: UITextField!
    
    @IBOutlet weak var agreecirclebtm: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func agreecircleBtm(_ sender: UIButton) {
        agreecirclebtm.setImage(UIImage(systemName: "circle.fill"), for: .normal)
    }
    
    
   
    @IBAction func SignUpBtm(_ sender: UIButton) {
    }
    
}
