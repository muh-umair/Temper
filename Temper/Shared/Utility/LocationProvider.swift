//
//  LocationProvider.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import CoreLocation

/// Protocol to define location provider service.
protocol LocationProviderProtocol {
    /// Returns current location of user
    var currentLocation: CLLocationCoordinate2D { get }
}

/// LocationProvider based on CoreLocation
final class LocationProvider: NSObject, LocationProviderProtocol {
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    private(set) var currentLocation: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
    
    // MARK: Initializer
    override init() {
        super.init()
        setupLocationManager()
        startLocationUpdates()
    }
    
    // MARK: - Helpers
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    private func startLocationUpdates() {
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: CLLocationManagerDelegate
extension LocationProvider: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location?.coordinate ?? currentLocation
    }
}

