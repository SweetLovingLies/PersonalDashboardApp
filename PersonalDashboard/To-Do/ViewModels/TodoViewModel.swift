//
//  TodoViewModel.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/28/25.
//

import SwiftUI
import UserNotifications
import SwiftData

class TodoViewModel: ObservableObject {
	@Published var newTaskTitle: String
	@Published var showToolbar: Bool
	@Published var selectedTime: Date
	@Published var showDatePicker: Bool
	
	func makeNotifications(item: ToDoItem) {
		guard let reminderTime = item.reminderTime else {
			print("No reminder time set.")
			return
		}
		
		let content = UNMutableNotificationContent()
		content.title = "Here's your reminder!"
		content.subtitle = "Complete this task: \(item.title)!"
		content.sound = .default
		
		let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderTime)
		let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
		
		let request = UNNotificationRequest(
			identifier: item.id.uuidString, // Use UUID so it can be removed/rescheduled later
			content: content,
			trigger: trigger
		)
		
		UNUserNotificationCenter.current().add(request) { error in
			if let error = error {
				print("Notification error: \(error)")
			} else {
				print("Notification set for \(reminderTime)")
			}
		}
	}

	
	init(newTaskTitle: String = "", showToolbar: Bool = false, selectedTime: Date = Date(), showDatePicker: Bool = false) {
		self.newTaskTitle = newTaskTitle
		self.showToolbar = showToolbar
		self.selectedTime = selectedTime
		self.showDatePicker = showDatePicker
	}
}
