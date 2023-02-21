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
    var select: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func agreecircleBtm(_ sender: UIButton) {
        if(select == 0){
            agreecirclebtm.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            select += 1
        }
        else
        {
            agreecirclebtm.setImage(UIImage(systemName: "circle"), for: .normal)
            select = 0
        }
    }
    
    
   
    @IBAction func SignUpBtm(_ sender: UIButton) {
    }
    
}
