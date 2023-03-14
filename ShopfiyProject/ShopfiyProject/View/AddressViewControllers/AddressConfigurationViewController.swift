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
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var streetTxtField: UITextField!
    
    var mapViewModel : MapViewModel!
    var addressViewModel : AddressViewModel!
    var location : CLLocation?
    var addressDelegate : AddressDelegate?
    var address : Customer_address?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapViewModel = MapViewModel()
        addressViewModel = AddressViewModel()
        
        countryTxtField.delegate = self
        cityTxtField.delegate = self
        streetTxtField.delegate = self
        
        if(address != nil){
            countryTxtField.text = address?.country
            cityTxtField.text = address?.city
            streetTxtField.text = address?.address1
        }
        else{
            mapViewModel.callLocationManagerToGetUserAddress()
            mapViewModel.bindResultToTableViewController = {
                self.renderLocationInMap(location : self.mapViewModel.vmResult ?? CLLocation())
            }
        }
            self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func renderLocationInMap(location : CLLocation){
        self.location = location
        DispatchQueue.main.async {
            self.addMapPin(with: location)
        }
    }
    
    func renderInTextFields(country : String?, city : String?, street : String?){
        DispatchQueue.main.async{
            self.countryTxtField.text = country
            self.cityTxtField.text = city
            self.streetTxtField.text = street
        }
    }
    
    @IBAction func tabRecognizer(_ sender: UITapGestureRecognizer) {
        let touchPoint : CGPoint = sender.location(in: mapView)
        let touchLocation : CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom:mapView)
        let newLocation = CLLocation(latitude: touchLocation.latitude, longitude: touchLocation.longitude)
        addMapPin(with: newLocation)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let country = countryTxtField.text
        let city = cityTxtField.text
        let street = streetTxtField.text
        
        if address != nil{
            addressViewModel.callNetworkServiceManagerToPut(customerAddressModel:CustomerAddressModel(customer_address: Customer_address(id : address?.id, country: country, city: city, address1: street))) { response in
                if response.statusCode >= 200 && response.statusCode <= 299{
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        else{
            addressViewModel.callNetworkServiceManagerToPost(customerAddressModel:CustomerAddressModel(customer_address: Customer_address(country: country, city: city, address1: street))) { response in
                if response.statusCode >= 200 && response.statusCode <= 299{
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        
       
        //let address = Customer_address(country: country, city: city, address1: street)
        //self.addressDelegate?.getAddress(address: address)
    }
    
    func addMapPin(with location: CLLocation){
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        zoomToUserLocation(location : location)
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapView.addAnnotation(pin)
        
        mapViewModel.callLocationManagerToGetLocationName(location: location)
        mapViewModel.bindResultToTableViewController = {
            self.renderInTextFields(country: self.mapViewModel.country, city: self.mapViewModel.city, street: self.mapViewModel.street)
        }
        
    }
    
    func zoomToUserLocation(location : CLLocation)
    {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
        mapView.setRegion(region, animated: true)
    }

}

extension AddressConfigurationViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        countryTxtField.endEditing(true)
        cityTxtField.endEditing(true)
        streetTxtField.endEditing(true)
        return true
    }
   
}

