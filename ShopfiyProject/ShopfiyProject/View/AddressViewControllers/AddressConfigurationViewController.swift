//
//  AddressConfigurationViewController.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 21/02/2023.
//

import UIKit
import MapKit
import CoreLocation

class AddressConfigurationViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var countryTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    
    var mapViewModel : MapViewModel!
    var location : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapViewModel = MapViewModel()
        mapViewModel.callLocationManagerToGetUserAddress()
        mapViewModel.bindResultToTableViewController = {
            self.renderLocationInMap(location : self.mapViewModel.vmResult ?? CLLocation())
        }
         
    }
    
    
    func renderLocationInMap(location : CLLocation){
        self.location = location
        DispatchQueue.main.async {
            self.addMapPin(with: location)
        }
    }
    
  
    
    @IBAction func tabRecognizer(_ sender: UITapGestureRecognizer) {
        let touchPoint : CGPoint = sender.location(in: mapView)
        let touchLocation : CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom:mapView)
        let newLocation = CLLocation(latitude: touchLocation.latitude, longitude: touchLocation.longitude)
        addMapPin(with: newLocation)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
    }
    
    func addMapPin(with location: CLLocation){
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        self.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 2.5, longitudeDelta: 2.5)), animated: true)
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapView.addAnnotation(pin)
        
        LocationManager.shared.getLocationName(with: location) { country, city in
            self.countryTxtField.text = country
            self.addressTxtField.text = city
        }
        
    }

}
