//
//  Point.swift
//  SportPoint
//
//  Created by Aksilont on 09.03.2023.
//

import Foundation
import CoreLocation

struct Coordinate: Codable {
    let lat: Double
    let long: Double
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}

struct Point: Codable {
    let name: String
    let type: TypeOfSportPoint
    let adress: String
    let coordinate: Coordinate
    let images: [String]?
    let description: String?
    let workTime: String?
    let phone: String?
    let webSite: String?
}
