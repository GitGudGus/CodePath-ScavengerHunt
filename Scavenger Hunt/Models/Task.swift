//
//  Task.swift
//  Scavenger Hunt
//
//  Created by Gustavo Pineda on 9/15/25.
//
import Foundation
import CoreLocation
import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var isCompleted: Bool = false
    var photo: UIImage? = nil
    var location: CLLocationCoordinate2D? = nil

    // Helper to set photo + location
    mutating func set(image: UIImage, with location: CLLocation?) {
        self.photo = image
        self.location = location?.coordinate
        self.isCompleted = true
    }
}


