//
//  SignUpScreenViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 20/02/2023.
//

import UIKit

class SignUpScreenViewController: UIViewController {
    
    @IBOutlet weak var phoneNumbTxt: UITextField!
    
    @IBOutlet weak var signupImg: UIImageView!
    
    
    @IBOutlet weak var usernameTxtfield: UITextField!
    
    @IBOutlet weak var emailTxtfield: UITextField!
    
    @IBOutlet weak var PassTextField: UITextField!
    
    
    @IBOutlet weak var conformPassTextField: UITextField!
    
    @IBOutlet weak var addressTxtfield: UITextField!
    
    @IBOutlet weak var agreecirclebtm: UIButton!
    var registerViewModel: RegisterViewModel?
    var select: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    registerViewModel = RegisterViewModel()
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
        guard let phoneNumber = phoneNumbTxt.text else {return}
        guard let address = addressTxtfield.text else {return}
        let defaultAddress = Address(id: nil, customer_id: nil, address1: address, address2: nil, city: nil, country: nil, phone: nil)
        if ValdiateCustomerInfomation(firstName: name, email: emailText, password: password, confirmPassword: confirmPass ,phone: phoneNumber , address : defaultAddress) {
            print("valid")
            register(firstName: name, email: emailText, password: password, confirmPassword: confirmPass , phone: phoneNumber, address : defaultAddress)
        } else {
            showAlertError(title: "Couldnot register", message: "Please try again later.")
        }
        
    }
}
extension SignUpScreenViewController {
    func ValdiateCustomerInfomation(firstName: String, email: String, password: String, confirmPassword: String ,phone : String , address : Address) -> Bool{
        
        var isSuccess = true
        self.registerViewModel?.ValdiateCustomerInfomation(firstName: firstName, email: email, password: password, confirmPassword: confirmPassword , phone: phone) { message in
            
            switch message {
            case "ErrorAllInfoIsNotFound":
                isSuccess = false
                self.showAlertError(title: "Missing Information", message: "please, enter all the required information.")
                
            case "ErrorPassword":
                isSuccess = false
                self.showAlertError(title: "Check Password", message: "password should be greater than 8 & password must be same as confirm pass")
                
            case "ErrorEmail":
                isSuccess = false
                self.showAlertError(title: "Invalid Email", message: "please, enter correct email.")
                
            case "ErroruserName":
                isSuccess = false
                self.showAlertError(title: "Invalid Name", message: "please,enter correct name .name should be greater than 8 & begin with later ")
                
            case "ErrorPhone":
                isSuccess = false
                self.showAlertError(title: "Invalid Number", message: "please,enter correct Number ")
            default:
                isSuccess = true
            }
        }
        return isSuccess
    }
    
    func register(firstName: String, email: String, password: String, confirmPassword: String , phone : String , address : Address){
        
        let customer = Customer(first_name: firstName, email: email, id: nil,phone: nil, tags: password, addresses: [address])
       
        let newCustomer = User(customer: customer)
        
        self.registerViewModel?.createNewCustomer(newCustomer: newCustomer) { data, response, error in
            
           guard error == nil else {
                DispatchQueue.main.async {
                    self.showAlertError(title: "Couldnot register", message: "Please, try again later.")
                }
                return
            }

            guard response?.statusCode != 422 else {
                DispatchQueue.main.async {
                    self.showAlertError(title: "Couldnot register", message: "Please, try another email.")
                }
                return
            }

            print("registered successfully")

            DispatchQueue.main.async {
                let login = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginScreenViewController
                self.navigationController?.pushViewController(login, animated: true)
            }
        }
        
    }
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
