//
//  ToDoItemView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/22/25.
//

import SwiftUI

struct ToDoItemView: View {
	@State var todoItem: ToDoItem
	@Environment(GlobalVM.self) var globalVM
	
    var body: some View {
		VStack {
			HStack {
				Image(systemName: todoItem.isCompleted ? "checkmark.square.fill" : "square")
					.foregroundStyle(todoItem.isCompleted ? globalVM.currentTheme.color(for: .accent3) : .gray)
					.font(.system(size: 25))
				
				Text(todoItem.title)
					.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.bodyFontSize))
					.strikethrough(todoItem.isCompleted)
					.animation(.default, value: todoItem.isCompleted)
					.multilineTextAlignment(.leading)
					.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
				
				Spacer()
				
				VStack{
					Spacer()
					if let reminder = todoItem.reminderTime {
						Text("Reminder Time: \(reminder.formatted(date: .omitted, time: .shortened))")
							.font(.custom(globalVM.currentTheme.lightFont, size: GlobalVM.captionFontSize))
					} else if let completedAt = todoItem.completedAt {
						Text("Completed at: \(completedAt.formatted(date: .omitted, time: .shortened))")
							.font(.custom(globalVM.currentTheme.lightFont, size: GlobalVM.captionFontSize))
					}
				}
				.frame(maxHeight: .infinity)
			}

			Rectangle()
				.frame(height: 3)
				.foregroundStyle(todoItem.isCompleted ? globalVM.currentTheme.color(for: .accent1) : .gray)
				.animation(.default, value: todoItem.isCompleted)
		}
    }
}

#Preview {
	ToDoItemView(todoItem: ToDoItem(title: "Test", reminderTime: .now))
		.environment(GlobalVM())
}
