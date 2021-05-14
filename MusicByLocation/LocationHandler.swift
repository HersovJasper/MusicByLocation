//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Jasper Hersov on 13/05/2021.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    @Published var lastKnownLocation: String = ""
    @Published var lastKnownCountry: String = ""
    @Published var lastKnownCoordinate: (String,String) = ("","")
    @Published var lastKnownAltitude: String = ""
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorisation() {
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            self.lastKnownCoordinate = ("\(firstLocation.coordinate.latitude)","\(firstLocation.coordinate.longitude)")
            self.lastKnownAltitude = ("\(firstLocation.altitude)")
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.lastKnownLocation = "Could not perform lookup of location from coordinate information"
                    self.lastKnownCountry = "Could not perform lookup of location from coordinate information"
                } else {
                    if let firstPlacemark = placemarks?[0] {
                        self.lastKnownLocation = firstPlacemark.locality ?? "Couldn't find locality"
                        self.lastKnownCountry = firstPlacemark.country ?? "Couldn't find locality"
                        //firstPlacemark.isoCountryCode ?? "Couldn't find country")
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lastKnownLocation = "Error finding location"
        lastKnownCountry = "Error finding location"
    }
}
