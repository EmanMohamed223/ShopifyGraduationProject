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
    
    
    @IBOutlet weak var conformPassTextField: UILabel!
    
    @IBOutlet weak var addressTxtfield: UITextField!
    
    @IBOutlet weak var agreecirclebtm: UIButton!
    var registerViewModel: RegisterViewModel?
    var select: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        guard let name = usernameTxtfield.text else {return}
        guard let emailText = emailTxtfield.text else {return}
        guard let password = PassTextField.text else {return}
        guard let confirmPass = conformPassTextField.text else {return}
        if ValdiateCustomerInfomation(firstName: name, email: emailText, password: password, confirmPassword: confirmPass) {
            print("valid")
           // register(firstName: name, email: emailText, password: password, confirmPassword: confirmPass)
        } else {
            showAlertError(title: "Couldnot register", message: "Please try again later.")
        }
        
    }
}
extension SignUpScreenViewController {
    func ValdiateCustomerInfomation(firstName: String, email: String, password: String, confirmPassword: String) -> Bool{
        
        var isSuccess = true
        self.registerViewModel?.ValdiateCustomerInfomation(firstName: firstName, email: email, password: password, confirmPassword: confirmPassword) { message in
            
            switch message {
            case "ErrorAllInfoIsNotFound":
                isSuccess = false
                self.showAlertError(title: "Missing Information", message: "please, enter all the required information.")
                
            case "ErrorPassword":
                isSuccess = false
                self.showAlertError(title: "Check Password", message: "please, enter password again.")
                
            case "ErrorEmail":
                isSuccess = false
                self.showAlertError(title: "Invalid Email", message: "please, enter correct email.")
                
            default:
                isSuccess = true
            }
        }
        return isSuccess
    }
    
 //   func register(firstName: String, email: String, password: String, confirmPassword: String){
        
       // let customer = Customer(first_name: firstName, email: email, id: nil, tags: password, addresses: nil)
       // let newCustomer = NewCustomer(customer: customer)
        
       // self.registerViewModel?.createNewCustomer(newCustomer: newCustomer) { data, response, error in
            
//           guard error == nil else {
//                DispatchQueue.main.async {
//                    self.showAlertError(title: "Couldnot register", message: "Please, try again later.")
//                }
//                return
//            }
//
//            guard response?.statusCode != 422 else {
//                DispatchQueue.main.async {
//                    self.showAlertError(title: "Couldnot register", message: "Please, try another email.")
//                }
//                return
//            }
//
//            print("registered successfully")
//
//            DispatchQueue.main.async {
//                let login = self.storyboard?.instantiateViewController(withIdentifier: "login")
//                self.navigationController?.pushViewController(login, animated: true)
//            }
//        }
        
   // }
}
extension UIViewController{
    func showAlertError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let Action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(Action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title:String, message:String, complition:@escaping ()->Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okButton = UIAlertAction(title: "OK", style: .destructive) { _ in
            complition()
        }
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
