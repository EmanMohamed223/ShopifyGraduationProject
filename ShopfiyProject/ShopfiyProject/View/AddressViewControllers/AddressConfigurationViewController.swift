//
//  AddressConfigurationViewController.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 21/02/2023.
//

import UIKit
import MapKit
import CoreLocation

class AddressConfigurationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var countryTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.shared.getUserLocation { location in
            DispatchQueue.main.async {
                self.addMapPin(with: location)
            }
        }
        
    }
    
    @IBAction func saveBtn(_ sender: Any) {
    }
    
    func addMapPin(with location: CLLocation){
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        self.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
        self.mapView.addAnnotation(pin)
        
        LocationManager.shared.getLocationName(with: location) { country, city in
            self.countryTxtField.text = country
            self.addressTxtField.text = city
        }
        
    }

}
