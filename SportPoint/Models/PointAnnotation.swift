//
//  PointAnnotation.swift
//  SportPoint
//
//  Created by Aksilont on 09.03.2023.
//

import Foundation
import MapKit

final class PointAnnotation: NSObject, MKAnnotation {
    
    var point: Point
    var coordinate: CLLocationCoordinate2D
    
    let selectedImage = UIImage(named: "SelectedPointMarker")
    let unselectedImage = UIImage(named: "UnselectedPointMarker")
    
    init(point: Point) {
        self.point = point
        self.coordinate = point.coordinate.locationCoordinate
    }
    
}
