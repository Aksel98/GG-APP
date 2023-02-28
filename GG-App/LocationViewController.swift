//
//  LocationViewController.swift
//  GG-App
//
//  Created by Aksel Avetisyan on 01.03.23.
//

import UIKit
import MapKit

final class LocationViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var locationName: UILabel!
    @IBOutlet private weak var stopUpdateLocationButton: UIButton!
    @IBOutlet private weak var startUpdateLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        locationName.isHidden = true
        setColors()
        setTexts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LocationManager.shared.getUserLocation(completion: { [weak self] location in
            guard let self else { return }

            self.pinCurrentLocation(location)
            self.setLocationName(location)
            self.disableButtons()
        })
    }
    
    private func pinCurrentLocation(_ location: CLLocation) {
        mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        mapView.showsUserLocation = true
    }
    
    private func setLocationName(_ location: CLLocation) {
        LocationManager.shared.resolveLocationName(with: location, completion: { [weak self] locationName in
            guard let self else { return }

            self.locationName.text = locationName
            self.locationName.isHidden = false
        })
    }
    
    private func setColors() {
        locationName.textColor = .baseColors.getBlack()
        startUpdateLocationButton.setTitleColor(.baseColors.getBlack(), for: .normal)
        stopUpdateLocationButton.setTitleColor(.baseColors.getBlack(), for: .normal)
        startUpdateLocationButton.setTitleColor(.baseColors.getBlack(), for: .disabled)
        stopUpdateLocationButton.setTitleColor(.baseColors.getBlack(), for: .disabled)
        startUpdateLocationButton.backgroundColor = .baseColors.getWhite()
        startUpdateLocationButton.layer.borderColor = UIColor.baseColors.getBlack().cgColor
        stopUpdateLocationButton.backgroundColor = .baseColors.getWhite()
        stopUpdateLocationButton.layer.borderColor = UIColor.baseColors.getBlack().cgColor
    }
    
    private func setTexts() {
        stopUpdateLocationButton.setTitle("Stop updating", for: .normal)
        startUpdateLocationButton.setTitle("Start updating", for: .normal)
    }
    
    private func disableButtons() {
        if LocationManager.shared.getIsLocationUpdate() {
            stopUpdateLocationButton.setEnable()
            startUpdateLocationButton.setDisable()
        } else {
            stopUpdateLocationButton.setDisable()
            startUpdateLocationButton.setEnable()
        }
    }
    
    @IBAction private func startUpdateLocationAction(_ sender: UIButton) {
        LocationManager.shared.setLocationUpdate(true)
        disableButtons()
    }
    
    @IBAction private func stopUpdateLocationAction(_ sender: UIButton) {
        LocationManager.shared.setLocationUpdate(false)
        disableButtons()
    }
}
