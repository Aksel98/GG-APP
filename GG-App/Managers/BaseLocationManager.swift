//
//  BaseLocationManager.swift
//  GG-App
//
//  Created by Aksel Avetisyan on 01.03.23.
//

import MapKit

class BaseLocationManager: CLLocationManager {
    
    var isUpdatingLocation = false
    
    override func startUpdatingLocation() {
        super.startUpdatingLocation()
        
        isUpdatingLocation = true
    }
    
    override func stopUpdatingLocation() {
        super.stopUpdatingLocation()
        
        isUpdatingLocation = false
    }
}
