//
//  StatsModel.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftData
import SwiftUI

@Observable
class StatsVM {
	private let context: ModelContext
	
	var sessions: [PomodoroSessionData] = []
	var todoTasks: [ToDoItem] = []

	init(context: ModelContext) {
		self.context = context
		loadData()
	}

	func loadData() {
		do {
			let sessionFetch = FetchDescriptor<PomodoroSessionData>()
			let taskFetch = FetchDescriptor<ToDoItem>()

			self.sessions = try context.fetch(sessionFetch)
			self.todoTasks = try context.fetch(taskFetch)
		} catch {
			print("Failed to fetch data: \(error)")
		}
	}
	
	// MARK: Logging
	
	func logPomodoro(duration: TimeInterval) {
		let today = Calendar.current.startOfDay(for: Date())

		if let existing = sessions.first(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
			existing.nSessions += 1
			existing.timeWorked += duration
		} else {
			let newSession = PomodoroSessionData(
				timeWorked: duration, date: today,
				nSessions: 1
			)
			context.insert(newSession)
			sessions.append(newSession)
		}

		do {
			try context.save()
		} catch {
			print("Failed to save session: \(error)")
		}
	}

	// MARK: Computed Stats
	var totalTimeWorked: TimeInterval {
		sessions.reduce(0) { $0 + $1.timeWorked }
	}

	var totalPomodoroSessions: Int {
		sessions.reduce(0) { $0 + $1.nSessions }
	}

	var averageSessionsPerDay: Double {
		let grouped = Dictionary(grouping: sessions) {
			Calendar.current.startOfDay(for: $0.date)
		}
		let dailyCounts = grouped.values.map { $0.reduce(0) { $0 + $1.nSessions } }
		return dailyCounts.map(Double.init).average()
	}

	var streaks: (current: Int, longest: Int) {
		calculateStreaks(from: sessions.map { $0.date })
	}

	var totalTasksCompleted: Int {
		todoTasks.filter { $0.completedAt != nil }.count
	}

	var averageTasksCompletedPerDay: Double {
		let completedDates = todoTasks.compactMap { $0.completedAt }.map {
			Calendar.current.startOfDay(for: $0)
		}
		let grouped = Dictionary(grouping: completedDates, by: { $0 })
		return grouped.map { $0.value.count }.map(Double.init).average()
	}

	var taskStreaks: (current: Int, longest: Int) {
		let completedDates = todoTasks.compactMap { $0.completedAt }
		return calculateStreaks(from: completedDates)
	}

	private func calculateStreaks(from dates: [Date]) -> (current: Int, longest: Int) {
		let uniqueDays = Set(dates.map { Calendar.current.startOfDay(for: $0) })
		let sortedDays = uniqueDays.sorted()

		var currentStreak = 0
		var longestStreak = 0
		var previousDay: Date?

		for day in sortedDays {
			if let prev = previousDay {
				let diff = Calendar.current.dateComponents([.day], from: prev, to: day).day ?? 0
				if diff == 1 {
					currentStreak += 1
				} else if diff > 1 {
					longestStreak = max(longestStreak, currentStreak)
					currentStreak = 1
				}
			} else {
				currentStreak = 1
			}
			previousDay = day
		}

		longestStreak = max(longestStreak, currentStreak)
		return (currentStreak, longestStreak)
	}
}


