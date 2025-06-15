//
//  TodoView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/15/25.
//

import SwiftUI
import SwiftData

struct TodoView: View {
	@State private var vm = TodoViewModel()
	@Environment(GlobalVM.self) private var globalVM

	
    var body: some View {
       TabView {
			TodoAddItemView()
				.tabItem {
					Image(systemName: "square")
					Text("List")
				}
				.environment(vm)
		   
		   TodoHistoryView()
			   .tabItem {
				   Image(systemName: "checkmark.square.fill")
				   Text("History")
			   }
			   .environment(vm)
		}
	   .tint(globalVM.currentTheme.color(for: .accent1))
	   .onAppear {
		   UITabBar.appearance().unselectedItemTintColor = globalVM.currentTheme.colorScheme == .dark ? UIColor.white : UIColor.gray
	   }
    }
}

#Preview {
	let config = ModelConfiguration(for: ToDoItem.self, isStoredInMemoryOnly: true)
	let container = try! ModelContainer(for: ToDoItem.self, configurations: config)
	
	let context = container.mainContext
	
	let sample1 = ToDoItem(title: "Sample Task")
	let sample2 = ToDoItem(title: "Sample Task 2")
	let sample3 = ToDoItem(title: "Sample Task 3")
	var sample4 = ToDoItem(title: "Sample Task 4")
	var sample5 = ToDoItem(title: "Sample Task 5")
	
	sample3.reminderTime = Date().addingTimeInterval(300)
	
	
	sample4.isCompleted = true
	sample4.completedAt = Date().addingTimeInterval(-100)
	
	sample5.isCompleted = true
	sample5.completedAt = Date().addingTimeInterval(-200)
	
	
	context.insert(sample1)
	context.insert(sample2)
	context.insert(sample3)
	context.insert(sample4)
	context.insert(sample5)
	
	return TodoView()
		.modelContainer(container)
		.environment(GlobalVM())
}
