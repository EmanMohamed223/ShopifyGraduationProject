//
//  MoreOrdersViewController.swift
//  ShopfiyProject
//
//  Created by Eman on 21/02/2023.
//

import UIKit

class MoreOrdersViewController: UIViewController {
    var orderVM : orderViewModel?
    var orderURL : String?
    var orderArray : [Order]?
  
    @IBOutlet weak var ordersTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTable.delegate = self
        ordersTable.dataSource = self
       
        ordersTable.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "ordercell")
        orderURL = getURL(endPoint: "orders.json")
        modelling(newUrl : getURL(endPoint: "customers/\( UserDefaultsManager.shared.getUserID() ?? 0)/orders.json"))
        self.ordersTable.reloadData()
    }

}
extension MoreOrdersViewController: UITableViewDelegate, UITableViewDataSource {
  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("**********")
        print(orderArray?.count ?? 0)
        return orderArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return CGFloat(1)
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView : UIView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "ordercell", for: indexPath) as! OrderTableViewCell
        cell.layer.cornerRadius = cell.frame.height/3
        cell.pricelabel.text = orderArray?[indexPath.row].current_total_price
        cell.dateOfOrderlabel.text =  orderArray?[indexPath.row].created_at
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension MoreOrdersViewController {
    func modelling(newUrl : String?){
        orderVM  = orderViewModel()
        orderVM?.getOrders(url: newUrl ?? "" )
      
        orderVM?.bindResultToOrderViewController  = { () in
            
            self.renderView()
        }
    }
    func renderView(){
        DispatchQueue.main.async {
            self.orderArray  = self.orderVM?.resultOrders.orders ?? []

            self.ordersTable.reloadData()
        }
    }
}
