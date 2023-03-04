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
    var orderArray : Orders?
    @IBOutlet weak var ordersTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTable.delegate = self
        ordersTable.dataSource = self
        ordersTable.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "ordercell")
        orderURL = getURL(endPoint: "orders.json")
        modelling(newUrl : orderURL)
        self.ordersTable.reloadData()
    }

}
extension MoreOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("**********")
        print(orderArray?.orders.count ?? 0)
        return orderArray?.orders.count ?? 0
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "ordercell", for: indexPath) as! OrderTableViewCell
        cell.pricelabel.text = orderArray?.orders[indexPath.row].current_subtotal_price
        cell.dateOfOrderlabel.text =  orderArray?.orders[indexPath.row].created_at
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height/4-40
    }
    
}
extension MoreOrdersViewController {
    func modelling(newUrl : String?){
        orderVM  = orderViewModel()
        orderVM?.getOrders(url: orderURL ?? "")
        orderVM?.bindResultToOrderViewController  = { () in
            
            self.renderView()
        }
    }
    func renderView(){
        DispatchQueue.main.async {
            self.orderArray  = self.orderVM?.resultOrders
          
            self.ordersTable.reloadData()
        }
    }
}
