//
//  MainView.swift
//  DashboardApp
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftUI
import SwiftData



struct MainView: View {
	@Environment(GlobalVM.self) private var globalVM
	@EnvironmentObject var navController: NavController
	@State private var currentSection: NavSection = .landing
	
	var body: some View {
		NavigationStack(path: $navController.path) {
			MainTabContainer(currentSection: $currentSection)
				.environmentObject(navController)
				.navigationDestination(for: Route.self) { route in
					switch route {
					case .reflection(let selectedMood):
						MoodReflectionView(mood: selectedMood)
							.environmentObject(navController)
					case .seedGet(let entry):
						SeedGetView(moodEntry: entry)
							.environmentObject(navController)
					case .garden:
						GardenView()
							.environmentObject(navController)
					case .wateringTransition(let seed):
						WateringTransition(seed: seed)
							.environmentObject(navController)
					}
				}
		}
	}
}

#Preview {
	let container = try! ModelContainer(
		for: ToDoItem.self, PomodoroSessionData.self,
		configurations: ModelConfiguration(isStoredInMemoryOnly: true)
	)
	let context = container.mainContext

	let statsVM = StatsVM(context: context)
	let globalVM = GlobalVM()

	let sampleData: [PomodoroSessionData] = [
		PomodoroSessionData(timeWorked: 30, date: .now, nSessions: 3),
		PomodoroSessionData(timeWorked: 30, date: .distantFuture, nSessions: 22),
		PomodoroSessionData(timeWorked: 30, date: .distantPast, nSessions: 48)
	]
	
	let sampleTodo: [ToDoItem] = [
		ToDoItem(title: "Notes Section"),
		ToDoItem(title: "Daily Mood Tracker"),
		ToDoItem(title: "Habit Tracker"),
		ToDoItem(title: "Make a simple version of SP")
	]
	
	for todo in sampleTodo {
		context.insert(todo)
	}

	for session in sampleData {
		context.insert(session)
	}
	try? context.save()

	return MainView()
		.environment(globalVM)
		.environment(statsVM)
		.modelContainer(container)
		.environmentObject(NavController())
}
