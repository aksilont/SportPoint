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
    func showCalloutView(point: Point)
    func hideCalloudView()
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
    
    // MARK: - Configure Map
    
    func configureMap() {
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    // MARK: - Methods
    
    func setupPoints(points: [Point]) {
        removeAllAnnotations()
        
        var annotations: [PointAnnotation] = []
        
        for point in points {
            let annotation = PointAnnotation(point: point)
            annotations.append(annotation)
        }
        mapView.showAnnotations(annotations, animated: true)
    }
    
    private func removeAllAnnotations() {
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
    }
    
    // MARK: - Camera
    
    func setCamera(to location: CLLocationCoordinate2D) {
        let span = mapView.region.span
        var newLocation = location
        newLocation.latitude -= 0.02 // поднять камеру чуть выше центра экрана
        let region = MKCoordinateRegion(center: newLocation, span: span)
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
        delegate?.showCalloutView(point: annotation.point)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let annotation = view.annotation as? PointAnnotation else { return }
        UIView.animate(withDuration: 0.3) {
            view.image = annotation.unselectedImage
        }
        delegate?.hideCalloudView()
    }
    
}

// MARK: - LocationManagerProtocol

extension AppleMapService: LocationManagerDelegate {
    func showAlert(title: String, message: String) {
        delegate?.showAlertMapService(title: title, message: message)
    }
    
    func didUpdateLocations(_ locations: [CLLocation]) {
        guard let locationCoordinate = locations.first?.coordinate
        else { return }
        currentLocation = locationCoordinate
    }
}
