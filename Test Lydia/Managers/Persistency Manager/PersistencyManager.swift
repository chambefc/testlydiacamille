//
//  PersistencyManager.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import Foundation
import SwiftData

protocol PersistencyManagerType {
    func addUsers(users: [User]) async
    func getCachedUsers() async -> [User]
    func addImageStep(step: ProgressiveImageView.ImageStep) async
    func deleteAll() async
    func getCachedImageStep(path: String) async -> ProgressiveImageView.ImageStep?
}

/// Allows the app to store User data using Apple's SwiftData.
@ModelActor
final actor PersistencyManager: PersistencyManagerType {

    private static let container = {
        do {
            let container = try ModelContainer(
                for: User.self,
                User.Login.self,
                User.Identity.self,
                User.Location.self,
                User.Coordinates.self,
                User.Street.self,
                User.TimeOrigin.self,
                User.Timezone.self,
                User.Picture.self,
                User.IDKey.self,
                ProgressiveImageView.ImageStep.self
            )
            return container
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }()

    static var shared: PersistencyManagerType = PersistencyManager(modelContainer: PersistencyManager.container)

    // Adds a list of users to the database
    func addUsers(users: [User]) {
        for user in users {
            modelContext.insert(user)
        }
    }
    
    // Retrieves all users from the local database
    func getCachedUsers() -> [User] {
        let fetchDescriptor = FetchDescriptor<User>()
        return (try? modelContext.fetch(fetchDescriptor)) ?? []
    }

    func addImageStep(step: ProgressiveImageView.ImageStep) {
        modelContext.insert(step)
    }

    func deleteAll() {
        try? modelContext.delete(model: User.self)
        try? modelContext.delete(model: ProgressiveImageView.ImageStep.self)
    }

    func getCachedImageStep(path: String) -> ProgressiveImageView.ImageStep? {
        let fetchDescriptor = FetchDescriptor<ProgressiveImageView.ImageStep>(
            predicate: #Predicate {
            $0.path == path
        })
        return try? modelContext.fetch(fetchDescriptor).first
    }
}
