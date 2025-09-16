//
//  TaskListViewModel.swift
//  Scavenger Hunt
//
//  Created by Gustavo Pineda on 9/15/25.
//
import Foundation
import SwiftUI
import CoreLocation

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = [
        Task(title: "Red Alert", description: "Take a photo of something bright red—bonus if it’s not a car!"),
        Task(title: "Bird Watcher", description: "Spot a bird that isn’t a pigeon and snap a picture."),
        Task(title: "Sign Me Up", description: "Find a street sign with a funny or unusual name."),
        Task(title: "Reflection Perfection", description: "Capture the city reflected in a window, puddle, or other shiny surface."),
        Task(title: "Quirky Vehicle", description: "Photograph a vehicle that isn’t a car—bike, scooter, truck, etc."),
        Task(title: "Shadow Animal", description: "Take a picture of a shadow that looks like an animal."),
        Task(title: "Flower Surprise", description: "Find a flower or plant growing somewhere unusual."),
        Task(title: "Foodie Snap", description: "Photograph a food item someone else is enjoying (keep it polite!)."),
        Task(title: "S for Something", description: "Capture something that starts with the letter 'S'."),
        Task(title: "Sci-Fi Moment", description: "Photograph something that looks like it belongs in a sci-fi movie."),
        Task(title: "Odd Object", description: "Find the weirdest object in a store window and take a picture."),
        Task(title: "Creative Color", description: "Take a photo of something with a pattern or color combination that looks surprisingly artistic.")
    ]

    let maxVisibleTasks = 3
        
        var visibleTasks: [Task] {
            Array(tasks.prefix(maxVisibleTasks))
        }
        
        func update(_ task: Task) {
            if let i = tasks.firstIndex(where: { $0.id == task.id }) {
                tasks[i] = task
            }
        }
        
        func resetTasks() {
            for i in tasks.indices {
                tasks[i].isCompleted = false
                tasks[i].photo = nil
                tasks[i].location = nil
            }
        }
        
        var allTasksCompleted: Bool {
            tasks.allSatisfy { $0.isCompleted }
        }
    }


