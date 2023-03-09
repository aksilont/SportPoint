//
//  LocationManager.swift
//  SportPoint
//
//  Created by Aksilont on 08.03.2023.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol: AnyObject {
    func showAlert(title: String, message: String)
    func didUpdateLocations(_ location: [CLLocation])
}

final class LocationManager: NSObject {
    
    // MARK: - Private properties
    
    private var locationManager: CLLocationManager!
    
    // MARK: -  Propertis
    
    var delegate: LocationManagerProtocol?
    
    // MARK: - Init
    
    override init() {
        super.init()
        configureLocationManager()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            let message = """
                          Нет прав на использовние Ваших координат.
                          Разрешите использовать Ваши координаты в настройках устройства
                          """
            delegate?.showAlert(title: "Ошибка", message: message)
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.didUpdateLocations(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let message = """
                      Возникла ошибка при определении местоположения.
                      Включите службу геолокации и разрешите доступ для приложения.
                      """
        delegate?.showAlert( title: "Ошибка", message: message)
        print(error.localizedDescription)
    }
    
}
