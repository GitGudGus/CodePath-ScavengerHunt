//
//  TaskDetailView.swift
//  Scavenger Hunt
//
//  Created by Gustavo Pineda on 9/15/25.
//
import SwiftUI
import CoreLocation
import MapKit

struct TaskDetailView: View {
    @State var task: Task
    var onSave: (Task) -> Void

    @State private var showPicker = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(task.title)
                            .font(.title2).bold()
                        Text(task.description).foregroundColor(.secondary)
                    }
                    Spacer()
                    if task.isCompleted {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.title2)
                    }
                }

                if let img = task.photo {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                        .cornerRadius(10)
                }

                if let loc = task.location {
                    TaskMapView(location: loc)
                        .frame(height: 260)
                }

                if !task.isCompleted {
                    Button(action: { showPicker = true }) {
                        Label("Attach Photo", systemImage: "camera.fill")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.85))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Task")
        .sheet(isPresented: $showPicker) {
            PhotoPicker { image, coordinate in
                // Update local copy and send updated task upstream
                task.set(image: image, with: coordinate.map { CLLocation(latitude: $0.latitude, longitude: $0.longitude) })
                onSave(task)
                showPicker = false
            }
        }
    }
}


