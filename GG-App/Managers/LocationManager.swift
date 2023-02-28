//
//  LocationManager.swift
//  GG-App
//
//  Created by Aksel Avetisyan on 01.03.23.
//

import MapKit

final class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private let manager = BaseLocationManager()
    private var completion: ((CLLocation) -> Void)?
        
    func getUserLocation(completion: @escaping (CLLocation) -> Void) {
        self.completion = completion
        setup()
    }
    
    func resolveLocationName(with location: CLLocation, completion: @escaping ((String) -> Void)) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
            guard let place = placemarks?.first, error == nil else { return }
            
            var locationName = place.locality ?? ""
            
            if let name = place.name {
                locationName += place.locality != nil ? ", \(name)" : name
            }
            
            completion(locationName)
        }
    }
    
    func setLocationUpdate(_ isUpdate: Bool) {
        guard manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways else { setup(); return }
        
        if isUpdate {
            manager.startUpdatingLocation()
        } else {
            manager.stopUpdatingLocation()
        }
    }
    
    func getIsLocationUpdate() -> Bool {
        return manager.isUpdatingLocation
    }
    
    private func setup() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = true
        manager.showsBackgroundLocationIndicator = true
        manager.delegate = self
        
        switch manager.authorizationStatus {
            case .authorizedWhenInUse:
                manager.startUpdatingLocation()
            case .authorizedAlways:
                manager.startUpdatingLocation()
            case .notDetermined:
                manager.requestAlwaysAuthorization()
            case .denied:
                showAlert(title: "Permission Denied", message: "Go to settings and turn on your location permission")
            case .restricted:
                showAlert(title: "Permission Restricted", message: "Go to settings and remove your location restriction")
            default:
                break
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        let settingsAction = UIAlertAction(title: "Settinngs", style: .default, handler: { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        
        alert.addAction(settingsAction)
        AppDelegate.getController()?.present(alert, animated: true, completion: nil)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        completion?(location)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        setup()
    }
}
