//
//  TaskMapView.swift
//  Scavenger Hunt
//
//  Created by Gustavo Pineda on 9/15/25.
//
import SwiftUI
import MapKit

struct _MapAnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct TaskMapView: View {
    let location: CLLocationCoordinate2D
    @State private var region: MKCoordinateRegion

    init(location: CLLocationCoordinate2D) {
        self.location = location
        _region = State(initialValue: MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }

    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems: [_MapAnnotationItem(coordinate: location)]) { item in
            // Simple pin. Use MapAnnotation for custom view (e.g., photo thumbnail) if desired.
            MapAnnotation(coordinate: item.coordinate) {
                VStack(spacing: 0) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.red)
                        .opacity(0.9)
                }
            }
        }
        .cornerRadius(12)
    }
}


