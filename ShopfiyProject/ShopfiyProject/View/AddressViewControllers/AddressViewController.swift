//
//  AddressViewController.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 20/02/2023.
//

import UIKit

class AddressViewController: UIViewController {

    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    

    
    @IBAction func addNewAddressBtn(_ sender: Any) {
    }
    
}

extension AddressViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AddressTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddressTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            completionHandler(true)
      }
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addressConfig") as! AddressConfigurationViewController
            self.navigationController?.pushViewController(vc, animated: true)
            completionHandler(true)
      }
        delete.backgroundColor = UIColor(named: "Blue")
        edit.backgroundColor = UIColor(named: "Red")
        let configuration = UISwipeActionsConfiguration(actions: [delete,edit])
        return configuration
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
