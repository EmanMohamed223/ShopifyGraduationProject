//
//  MapViewModel.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 25/02/2023.
//

import Foundation
import CoreLocation


class MapViewModel{

    var bindResultToTableViewController : (()->()) = {}
    
    var vmResult : CLLocation?{
        didSet{
            bindResultToTableViewController()
        }
    }
    
    func callLocationManagerToGetUserAddress(){
        LocationManager.shared.getUserLocation { location in
            self.vmResult = location
        }
    }
    
}
