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
    var loginViewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    loginViewModel = LoginViewModel()
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
        guard let email = emailTxtfield.text, !email.isEmpty
            , let password = passtextField.text, !password.isEmpty else {
            self.showAlertError(title: "Missing Information", message: "to login you must fill all the information below.")
            return
        }
        
        loginViewModel?.Login(email: email, password: password) { customerLogged in
            
            if customerLogged != nil {
                UserDefaultsManager.shared.setUserStatus(userIsLogged: true)
                print("customer logged in successfully")
                //Navigation
                //with second view
            }else{
                UserDefaultsManager.shared.setUserStatus(userIsLogged: false)
                self.showAlertError(title: "failed to login", message: "please check your email or password")
                print("failed to login")
            }
        }
    }
        
        
        
        
    
    
    @IBAction func GoToSignUpBtm(_ sender: UIButton) {
         var signup = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpScreenViewController
        self.present(signup, animated: true)
    }
    
  

}
