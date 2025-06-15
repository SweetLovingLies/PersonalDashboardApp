//
//  PersonalDashboardApp.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftUI

@main
struct PersonalDashboardApp: App {
	@State private var navController = NavController()
	
    var body: some Scene {
        WindowGroup {
            RootView()
				.modelContainer(for: [ToDoItem.self, PomodoroSessionData.self, MoodEntry.self, Note.self])
				.environmentObject(navController)
        }
    }
}
