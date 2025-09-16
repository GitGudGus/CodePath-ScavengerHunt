//
//  AllTasksMapView.swift
//  Scavenger Hunt
//
//  Created by Gustavo Pineda on 9/15/25.
//
import SwiftUI
import MapKit

struct AllTasksMapView: View {
    let tasks: [Task]
    var onReset: (() -> Void)?
    
    @State private var region: MKCoordinateRegion
    
    init(tasks: [Task], onReset: (() -> Void)? = nil) {
        self.tasks = tasks
        self.onReset = onReset
        if let firstLoc = tasks.compactMap({ $0.location }).first {
            _region = State(initialValue: MKCoordinateRegion(
                center: firstLoc,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
        } else {
            _region = State(initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            ))
        }
    }
    
    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems: tasks.compactMap { task in
                task.location.map { LocationAnnotation(coordinate: $0) }
            }) { annotation in
            MapMarker(coordinate: annotation.coordinate, tint: .green)
        }
        .ignoresSafeArea()
        .navigationTitle("All Found Locations")
        .toolbar {
            Button("Restart Hunt") {
                onReset?()
            }
        }
    }
}

