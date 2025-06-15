//
//  ToDoItemView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/22/25.
//

import SwiftUI

struct ToDoItemView: View {
	@State var taskItem: ToDoItem
	@Environment(GlobalVM.self) var globalVM
	@State private var viewModel = TodoViewModel()
	
    var body: some View {
		VStack {
			HStack() {
				Image(systemName: taskItem.isCompleted ? "checkmark.square.fill" : "square")
					.foregroundStyle(taskItem.isCompleted ? globalVM.currentTheme.color(for: .accent3) : .gray)
					.font(.system(size: 25))
				
				Text(taskItem.title)
					.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.bodyFontSize))
					.strikethrough(taskItem.isCompleted)
					.animation(.default, value: taskItem.isCompleted)
					.multilineTextAlignment(.leading)
					.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
				
				Spacer()
				
				if let reminder = taskItem.reminderTime {
					Text(reminder.formatted(date: .omitted, time: .shortened))
						.font(.custom(globalVM.currentTheme.lightFont, size: GlobalVM.captionFontSize))
				}
					
				
			}
			
			Rectangle()
				.frame(height: 3)
				.foregroundStyle(taskItem.isCompleted ? globalVM.currentTheme.color(for: .accent1) : .gray)
				.animation(.default, value: taskItem.isCompleted)
		}
    }
}

#Preview {
	ToDoItemView(taskItem: ToDoItem(title: "Test", reminderTime: .now))
		.environment(GlobalVM())
}
