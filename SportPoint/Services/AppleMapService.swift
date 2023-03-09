//
//  AppleMapService.swift
//  SportPoint
//
//  Created by Aksilont on 09.03.2023.
//

import Foundation
import CoreLocation
import MapKit

protocol MapServiceDelegate: AnyObject {
    func showAlertMapService(title: String, message: String)
}

final class AppleMapService: NSObject {
    
    // MARK: - Private Properties
    
    private var locationManager: LocationManager?
    
    private var route: [CLLocationCoordinate2D] = []
    private var lastRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    // MARK: - Public Properties
    
    weak var delegate: MapServiceDelegate?
    var mapView: MKMapView
    var currentLocation: CLLocationCoordinate2D?
    
    // MARK: - Init
    
    required init(mapView: MKMapView) {
        self.mapView = mapView
        super.init()
        configureMap()
        locationManager = LocationManager(delegate: self)
    }
    
    // MARK: - Configure
    
    func configureMap() {
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    func setupPoints(points: [Point]) {
        var annotations: [PointAnnotation] = []
        
        for point in points {
            let annotation = PointAnnotation(point: point)
            annotations.append(annotation)
        }
        mapView.showAnnotations(annotations, animated: true)
        
        var region = mapView.region
        region.span.latitudeDelta *= 1.5
        region.span.longitudeDelta *= 1.5
        lastRegion = region
        mapView.setRegion(lastRegion, animated: true)
    }
    
    // MARK: - Camera
    
    func setCamera(to location: CLLocationCoordinate2D) {
        let span = mapView.region.span
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func setCameraToCurrentLocation() {
        guard let currentLocation else { return }
        setCamera(to: currentLocation)
    }
    
    func setCameraToRoute(with coordinates: [CLLocationCoordinate2D]) {
        let routePolyLine = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(routePolyLine)
        
        let mapRect = routePolyLine.boundingMapRect.insetBy(dx: -500, dy: -500)
        mapView.setVisibleMapRect(mapRect, animated: true)
    }
    
    // MARK: - Deinit
    
    deinit {
        locationManager?.stopUpdatingLocation()
    }
    
}

// MARK: - MKMapViewDelegate

extension AppleMapService: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation { return nil }
        
        let reuseIdentifier = "pin"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation,
                                              reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }
        
        let customPointAnnotation = annotation as! PointAnnotation
        annotationView?.image = customPointAnnotation.unselectedImage
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? PointAnnotation else { return }
        
        UIView.animate(withDuration: 0.3) {
            view.image = annotation.selectedImage
        }
        
        setCamera(to: annotation.coordinate)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let annotation = view.annotation as? PointAnnotation else { return }
        UIView.animate(withDuration: 0.3) {
            view.image = annotation.unselectedImage
        }
    }
    
}

// MARK: - LocationManagerProtocol

extension AppleMapService: LocationManagerProtocol {
    func showAlert(title: String, message: String) {
        delegate?.showAlertMapService(title: title, message: message)
    }
    
    func didUpdateLocations(_ locations: [CLLocation]) {
        guard let locationCoordinate = locations.first?.coordinate
        else { return }
        currentLocation = locationCoordinate
    }
}
