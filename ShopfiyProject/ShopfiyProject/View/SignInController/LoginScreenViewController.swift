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
    var customers : [Customer] = []
        var ResultArray : CustomerResponse?
        // var viewModel : CustomerViewModel?
        var viewModel = CustomerViewModel()
        var currentCustomer : Customer?

    override func viewDidLoad() {
        super.viewDidLoad()
   
        loginViewModel = LoginViewModel()
                // Do any additional setup after loading the view.
                modiling()

        
    }
    func modiling() {
            viewModel.getcustomers(url: getURL(endPoint: "customers.json"))
            viewModel.bindResultToViewController = { () in
                
                self.renderView()
            }
            
        }
        func renderView(){
            
            self.ResultArray = self.viewModel.Users
            self.customers = self.ResultArray!.customers
            
            print ("render is done ")
            
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
                for customer in customers {
                    if customer.email == email && customer.tags == password {
                        currentCustomer = customer
                    }
                }
                if currentCustomer != nil{
                    self.saveCustomerDataToUserDefaults(customer: currentCustomer!)
                    UserDefaultsManager.shared.setUserStatus(userIsLogged: true)
                    
                    print("customersaved")
                    var me = self.storyboard?.instantiateViewController(withIdentifier: "Me2") as! MeViewController
                    self.navigationController?.pushViewController(me, animated: true)
                }
                else {
                    UserDefaultsManager.shared.setUserStatus(userIsLogged: false)
                    self.showAlertError(title: "failed to login", message: "please check your email or password")
                    print("failed to login")
                }
            }

        //        loginViewModel?.Login(email: email, password: password) { customerLogged in
        //
        //            if customerLogged != nil {
        //                UserDefaultsManager.shared.setUserStatus(userIsLogged: true)
        //                print("customer logged in successfully")
        //                var me = self.storyboard?.instantiateViewController(withIdentifier: "Me2") as! MeViewController
        //                self.navigationController?.pushViewController(me, animated: true)
        //                //Navigation
        //                //with second view
        //            }else{
        //                UserDefaultsManager.shared.setUserStatus(userIsLogged: false)
        //                self.showAlertError(title: "failed to login", message: "please check your email or password")
        //                print("failed to login")
        //            }
        //        }
          
                
                
            func saveCustomerDataToUserDefaults(customer: Customer){
                guard let customerID = customer.id else {return}
                guard let userFirstName = customer.first_name else {return}
                guard let userEmail = customer.email  else {return}

                UserDefaultsManager.shared.setUserID(customerID: customerID)
                UserDefaultsManager.shared.setUserName(userName: userFirstName)
                UserDefaultsManager.shared.setUserEmail(userEmail: userEmail)
            }
                
            
        
        
        
        
    
    
    @IBAction func GoToSignUpBtm(_ sender: UIButton) {
         var signup = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpScreenViewController
        self.present(signup, animated: true)
    }
    
  

}
