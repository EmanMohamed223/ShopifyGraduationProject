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
    var country,city : String?
    
    var street : String?{
        didSet{
            bindResultToTableViewController()
        }
    }
    
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
    
    func callLocationManagerToGetLocationName(location : CLLocation){
        LocationManager.shared.getLocationName(with: location) { country, city, street in
            self.country = country
            self.city = city
            self.street = street
        }
    }
    
}
