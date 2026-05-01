//
//  TodoItem.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import Foundation
import SwiftData

@Model
class ToDoItem: Identifiable {
	@Attribute(.unique) var id: UUID
	var title: String
	
	var createdAt: Date
	var isCompleted: Bool
	var completedAt: Date?
	
	var reminderTime: Date?
	
	var sortOrder: Int?
	
	init(title: String, createdAt: Date = Date(),  completedAt: Date? = nil, reminderTime: Date? = nil, sortOrder: Int? = nil) {
		self.id = UUID()
		self.title = title
		self.createdAt = createdAt
		self.isCompleted = false
		self.completedAt = completedAt
		self.reminderTime = reminderTime
		self.sortOrder = sortOrder
	}
}
