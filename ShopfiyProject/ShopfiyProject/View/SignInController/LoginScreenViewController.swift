//
//  LoginScreenViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 20/02/2023.
//

import UIKit

class LoginScreenViewController: UIViewController {
    @IBOutlet weak var loginimage: UIImageView!
    
    @IBOutlet weak var emailTxtfield: UITextField!
    
    
    @IBOutlet weak var passtextField: UITextField!
    
    @IBOutlet weak var remembermecircle: UIButton!
    var select: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func remembermebtm(_ sender: UIButton) {
        if(select == 0){
        remembermecircle.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            select += 1
        }
        else
        {
            remembermecircle.setImage(UIImage(systemName: "circle"), for: .normal)
            select = 0
        }
    }
    
    @IBAction func forgetPassBtm(_ sender: UIButton) {
        
    }
    @IBAction func LoginBtm(_ sender: UIButton) {
    }
    
    @IBAction func GoToSignUpBtm(_ sender: UIButton) {
         var signup = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpScreenViewController
        self.present(signup, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
