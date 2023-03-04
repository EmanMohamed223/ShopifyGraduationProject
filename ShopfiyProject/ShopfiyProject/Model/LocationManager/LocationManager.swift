//
//  LocationManager.swift
//  ShopfiyProject
//
//  Created by Mariam Moataz on 24/02/2023.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager : NSObject, CLLocationManagerDelegate, MKMapViewDelegate{
    static let shared = LocationManager()
    private override init(){}
    let manager = CLLocationManager()
    var completion : ((CLLocation) -> Void)?
    
    //compilation to send back the results
    func getLocationName(with location:CLLocation, completion: @escaping((String?,String?,String?) -> Void)){
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
            guard let place = placemarks?.first, error == nil else{
                completion(nil,nil,nil)
                return
            }
            
            //the city associated with the placemark
            guard let locality = place.country else{ return }
            let country = locality
            //the state or city associated with the placemark
            guard let locality = place.administrativeArea else{ return }
            let city = locality
            guard let locality = place.name else{ return }
            let street = locality
            completion(country,city,street)
        }
    }
    
    func getUserLocation(completion : @escaping (CLLocation) -> Void){
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else{ return}
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
