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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let userId = UserDefaultsManager.shared.getUserID()
        let url = getURL(endPoint: "customers/\(userId ?? 0)/addresses.json?limit=10")
        addressViewModel.callNetworkServiceManagerToGetAddresses(url: url)
        addressViewModel.bindResultToViewController = {
            self.renderAddresses(addresses: self.addressViewModel.resultModel)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
            self.addressArr.addresses?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            completionHandler(true)
      }
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addressConfig") as! AddressConfigurationViewController
            vc.address = Customer_address()
            vc.address = self.addressArr.addresses?[indexPath.row] ?? Customer_address()
            self.navigationController?.pushViewController(vc, animated: true)
            completionHandler(true)
      }
        delete.backgroundColor = UIColor(named: "delete")
        edit.backgroundColor = UIColor(named: "edit")
        let configuration = UISwipeActionsConfiguration(actions: [delete,edit])
        return configuration
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
        self.navigationController?.pushViewController(vc, animated: true)
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

