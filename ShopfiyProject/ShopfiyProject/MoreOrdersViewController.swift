//
//  MoreOrdersViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 21/02/2023.
//

import UIKit

class MoreOrdersViewController: UIViewController {

    @IBOutlet weak var ordersTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTable.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "ordercell")
        
    }

}
extension MoreOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "ordercell", for: indexPath) as! OrderTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/4-40
    }
    
}
