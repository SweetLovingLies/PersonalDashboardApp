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
		VStack(alignment: .leading) {
			HStack(alignment: .top) {
				Image(systemName: todoItem.isCompleted ? "checkmark.square.fill" : "square")
					.foregroundStyle(todoItem.isCompleted ? globalVM.currentTheme.color(for: .accent3) : .gray)
					.font(.system(size: 25))
					.padding(.trailing, 10)
				
				VStack(alignment: .leading, spacing: 0) {
					Text(todoItem.title)
						.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.bodyFontSize))
						.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
					
						.strikethrough(todoItem.isCompleted)
						.animation(.default, value: todoItem.isCompleted)
					
						.fixedSize(horizontal: false, vertical: true)
						.multilineTextAlignment(.leading)
						.lineLimit(3)

					
					
					VStack {
						if let reminder = todoItem.reminderTime {
							Text("Reminder: \(reminder.formatted(date: .complete, time: .shortened))")
								.font(.custom(globalVM.currentTheme.lightFont, size: GlobalVM.captionFontSize))
								.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary).opacity(0.5))
						} else if let completedAt = todoItem.completedAt {
							Text("Completed: \(completedAt.formatted(date: .complete, time: .shortened))")
								.font(.custom(globalVM.currentTheme.lightFont, size: GlobalVM.captionFontSize))
								.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary).opacity(0.5))
						}
					}
					.frame(maxHeight: .infinity)
				}
			}

			Rectangle()
				.frame(height: 3)
				.foregroundStyle(todoItem.isCompleted ? globalVM.currentTheme.color(for: .accent1) : .gray)
				.animation(.default, value: todoItem.isCompleted)
		}
    }
}

#Preview {
	ToDoItemView(todoItem: ToDoItem(title: "This is a really long to-do item, meant for testing text wrapping!", reminderTime: .now))
		.environment(GlobalVM())
}

