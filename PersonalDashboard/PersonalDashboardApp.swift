//
//  PersonalDashboardApp.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftUI
import SwiftData

@main
struct PersonalDashboardApp: App {
	@State private var navController = NavController()
	let modelContainer: ModelContainer

	init() {
		do {
			modelContainer = try ModelContainer(
				for: ToDoItem.self, PomodoroSessionData.self, MoodEntry.self, Note.self
			)
		} catch {
			fatalError("❌ Failed to initialize SwiftData container: \(error.localizedDescription)")
		}
	}

	var body: some Scene {
		WindowGroup {
			RootView()
				.modelContainer(modelContainer)
				.environmentObject(navController)
		}
	}
}
