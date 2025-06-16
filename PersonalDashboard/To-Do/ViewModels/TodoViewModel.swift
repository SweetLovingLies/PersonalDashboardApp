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
	
	func makeNotifications() {
		let content = UNMutableNotificationContent()
		content.title = "Here's your reminder!"
		content.subtitle = "Complete this task: \(newTaskTitle)!"
		content.sound = UNNotificationSound.default
		
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
		
		let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
		
		UNUserNotificationCenter.current().add(request)
	}
	
	init(newTaskTitle: String = "", showToolbar: Bool = false, selectedTime: Date = Date(), showDatePicker: Bool = false) {
		self.newTaskTitle = newTaskTitle
		self.showToolbar = showToolbar
		self.selectedTime = selectedTime
		self.showDatePicker = showDatePicker
	}
}
