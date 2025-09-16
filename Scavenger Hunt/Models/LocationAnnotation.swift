//
//  LocationAnnotation.swift
//  Scavenger Hunt
//
//  Created by Gustavo Pineda on 9/15/25.
//
import Foundation
import CoreLocation

struct LocationAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}


