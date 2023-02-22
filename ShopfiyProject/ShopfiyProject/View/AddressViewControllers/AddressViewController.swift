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
    
    
    @IBAction func editAddressBtn(_ sender: Any) {
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
    
}
