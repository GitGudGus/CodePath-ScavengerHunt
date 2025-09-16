//
//  TaskListView.swift
//  Scavenger Hunt
//
//  Created by Gustavo Pineda on 9/15/25.
//
import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel = TaskListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.visibleTasks) { task in
                    NavigationLink(
                        destination: TaskDetailView(task: task) { updated in
                            viewModel.update(updated)
                        }
                    ) {
                        HStack {
                            Text(task.title)
                            Spacer()
                            if task.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
                
                if viewModel.allTasksCompleted {
                    NavigationLink(
                        destination: AllTasksMapView(tasks: viewModel.tasks) {
                            viewModel.resetTasks()
                        }
                    ) {
                        HStack {
                            Image(systemName: "map.fill").foregroundColor(.green)
                            Text("View All Completed Locations")
                                .foregroundColor(.green)
                                .bold()
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Welcome to Scavenger Hunt!")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
