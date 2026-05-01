//
//  RoutineItem.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 8/23/25.
//

import SwiftData
import SwiftUI

@Model
class RoutineItem: Identifiable {
	@Attribute(.unique) var id: UUID
    var title: String
	
    var reminderTime: Date?
	
    var isCompletedToday: Bool = false
	var completedDate: Date?
	var sortOrder: Int?

	init(
		title: String,
		reminderTime: Date? = nil,
		completedDate: Date? = nil,
		sortOrder: Int? = nil
	) {
        self.id = UUID()
        self.title = title
        self.reminderTime = reminderTime
		self.completedDate = completedDate
    }
}

extension RoutineItem {
	static let defaultRoutines: [RoutineItem] = [
		RoutineItem(title: "Make Bed"),
		RoutineItem(title: "Take a shower"),
		RoutineItem(title: "Skincare"),
		RoutineItem(title: "Get dressed"),
		RoutineItem(title: "Eat breakfast"),
		RoutineItem(title: "Stretch / Workout"),
		RoutineItem(title: "Lunch"),
		RoutineItem(title: "Dinner"),
		RoutineItem(title: "Get off Electronics"),
	]
}

