//
//  AddressViewController.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 20/02/2023.
//

import UIKit

class AddressViewController: UIViewController {

        
    @IBOutlet weak var tableView: UITableView!

    var addressArr = CustomerAddressGetModel()
    let addressViewModel = AddressViewModel()
    var addressModelToBeDeleted : CustomerAddressModel?
    static var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        let userId = UserDefaultsManager.shared.getUserID()
        let url = getURL(endPoint: "customers/\(userId ?? 0)/addresses.json?limit=10")
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        addressViewModel.callNetworkServiceManagerToGetAddresses(url: url)
        addressViewModel.bindResultToViewController = {
            self.renderAddresses(addresses: self.addressViewModel.resultModel)
            indicator.stopAnimating()
        }
        tableView.reloadData()
    }
    

    
    @IBAction func addNewAddressBtn(_ sender: Any) {
        let addressConfigVC = self.storyboard?.instantiateViewController(withIdentifier: "addressConfig") as! AddressConfigurationViewController
        addressConfigVC.addressDelegate = self
        self.navigationController?.pushViewController(addressConfigVC, animated: true)
    }
    
}

extension AddressViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArr.addresses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AddressTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddressTableViewCell
        cell.countryLabel.text = addressArr.addresses?[indexPath.row].country
        cell.cityLabel.text = addressArr.addresses?[indexPath.row].city
        cell.streetLabel.text = addressArr.addresses?[indexPath.row].address1
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            if indexPath.row == 0{
                let alert = UIAlertController(title: "Alert", message: "Default address can not be deleted, you can just edit it!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default){_ in })
                self.present(alert, animated: true)
            }
            else{
                self.addressModelToBeDeleted = CustomerAddressModel(customer_address: self.addressArr.addresses?[indexPath.row])
                self.addressViewModel.callNetworkServiceManagerToDelete(customerAddressModel: self.addressModelToBeDeleted ?? CustomerAddressModel())
                self.addressArr.addresses?.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                completionHandler(true)
            }
      }
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addressConfig") as! AddressConfigurationViewController
            vc.address = Customer_address()
            vc.address = self.addressArr.addresses?[indexPath.row] ?? Customer_address()
            self.navigationController?.pushViewController(vc, animated: true)
            completionHandler(true)
      }
        delete.backgroundColor = UIColor(named: "red")
        edit.backgroundColor = UIColor(named: "clay")
        let configuration = UISwipeActionsConfiguration(actions: [delete,edit])
        return configuration
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !Self.flag{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
        vc.address = addressArr.addresses?[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension AddressViewController : AddressDelegate{
    func getAddress(address: Customer_address?) {
        addressArr.addresses?.append(address ?? Customer_address())
        tableView.reloadData()
    }
    
    func renderAddresses(addresses : CustomerAddressGetModel){
        self.addressArr = addresses
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}

