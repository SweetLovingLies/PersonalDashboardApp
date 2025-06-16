//
//  TodoAddItemView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftUI
import SwiftData
import UserNotifications

struct TodoAddItemView: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(GlobalVM.self) private var globalVM
	@StateObject private var vm = TodoViewModel()
	
	@FocusState private var isFocused: Bool
	
	@Query(sort: \ToDoItem.sortOrder) var todoItems: [ToDoItem]
	init() {
		_todoItems = Query(filter: #Predicate {
			$0.isCompleted == false
		})
	}
	
	var body: some View {
		ZStack {
			globalVM.currentTheme.color(for: .mainBG)
				.ignoresSafeArea()
			
			VStack(alignment: .trailing, spacing: 0) {
				
				// MARK: Header
				ZStack {
					globalVM.currentTheme.color(for: .headerBG)
						.ignoresSafeArea()
					
					Text("To-Do")
						.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.headerFontSize))
							.foregroundStyle(globalVM.currentTheme.color(for: .textHeader))
				}
				.frame(height: GlobalVM.headerHeight)
				
				// MARK: Toolbar
				if vm.showToolbar {
					ZStack(alignment: .trailing) {
						globalVM.currentTheme.color(for: .accent1)
						
						HStack {
							
							if vm.showDatePicker {
								HStack {
									DatePicker("Reminder Time", selection: $vm.selectedTime, displayedComponents: .hourAndMinute)
										.labelsHidden()
										.tint(globalVM.currentTheme.color(for: .accent3))
									
									Button(action: {vm.showDatePicker = false}) {
										Image(systemName: "xmark.circle.fill")
											.accessibilityLabel("Remove Reminder Time")
									}
									.tint(globalVM.currentTheme.color(for: .accent3))
								}
								
							} else {
								Button(action: {
									vm.showDatePicker = true
								}) {
									Text("Set Reminder")
								}
								.buttonStyle(.borderedProminent)
								.tint(globalVM.currentTheme.color(for: .accent3))
								.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.buttonFontSize))
								.foregroundStyle(globalVM.currentTheme.color(for: .textSecondary))
							}
							
							EditButton()
								.buttonStyle(.borderedProminent)
								.padding(.trailing, 10)
								.tint(globalVM.currentTheme.color(for: .accent3))
								.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.buttonFontSize))
								.foregroundStyle(globalVM.currentTheme.color(for: .textSecondary))
						}
					}
					.frame(height: 50)
					.transition(.move(edge: .top))
					.zIndex(-1) // Forces the bar behind the header
				}
				
				// MARK: Addition Bar
				HStack {
					Button(action: {
						withAnimation {
							vm.showToolbar.toggle()
						}
					}) {
						ZStack {
							ZStack(alignment: .bottom) {
								if vm.showToolbar {
									globalVM.currentTheme.color(for: .accent1)
								} else {
									globalVM.currentTheme.color(for: .headerBG)
								}
								
								Triangle()
									.frame(height: 15)
									.foregroundStyle(globalVM.currentTheme.color(for: .mainBG))
							}
							
							Image(systemName: vm.showToolbar ? "chevron.up" : "chevron.down")
								.foregroundStyle(globalVM.currentTheme.color(for: .textSecondary))
								.offset (y: -5)
						}
						.frame(width: 30, height: 40)
						.offset(y: -1)
						.animation(nil, value: vm.showToolbar)
					}
					.buttonStyle(RawButtonStyle())
					
					TextField("",
							  text: $vm.newTaskTitle,
							  prompt: Text("What's next?")
						.foregroundStyle(
							globalVM.currentTheme.color(for: .textFieldPlaceholder)
								.opacity(0.7)
						)
			
					)
					.textFieldStyle(TodoTextfieldStyle(globalVM: globalVM))
					.focused($isFocused)
					
					Button("Add") {
						guard !vm.newTaskTitle.isEmpty else { return }
						let newTask = ToDoItem(title: vm.newTaskTitle, reminderTime: !vm.showDatePicker || !vm.showToolbar ? nil : vm.selectedTime)
						modelContext.insert(newTask)
						try? modelContext.save()
						
						vm.makeNotifications(item: newTask)
						
						
						isFocused = false
						vm.newTaskTitle = ""
					}
					.buttonStyle(.borderedProminent)
					.tint(globalVM.currentTheme.color(for: .accent3))
					.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.buttonFontSize))
					.foregroundStyle(globalVM.currentTheme.color(for: .textSecondary))
				}
				.frame(height: 40)
				.padding(.horizontal, 10)
				.padding(.bottom)
				
				// MARK: List
				List {
					if todoItems.isEmpty {
						ToDoItemView(todoItem: ToDoItem(title: "I'm getting bored over here..."))
							.listRowSeparator(.hidden)
							.listRowBackground(Color.clear)
					} else {
						ForEach(todoItems, id: \.self) { item in
							ToDoItemView(todoItem: item)
								.listRowSeparator(.hidden)
								.listRowBackground(Color.clear)
								.onTapGesture {
									item.isCompleted.toggle()
									item.completedAt = .now
								}
						}
						.onMove { from, to in
							var updatedItems = todoItems
							updatedItems.move(fromOffsets: from, toOffset: to)
							
							for i in updatedItems.indices {
								updatedItems[i].sortOrder = i
							}
							
							try? modelContext.save()
						}
						
						.onDelete { indexSet in
							for index in indexSet {
								UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [todoItems[index].id.uuidString])
								modelContext.delete(todoItems[index])
							}
						}
					}
						
				}
				.listStyle(.plain)
				.listRowSpacing(20)
				.scrollContentBackground(.hidden)
			}
		}
	}
}

#Preview {
	let config = ModelConfiguration(for: ToDoItem.self, isStoredInMemoryOnly: true)
	let container = try! ModelContainer(for: ToDoItem.self, configurations: config)
	
	let context = container.mainContext
	context.insert(ToDoItem(title: "Sample Task"))
	context.insert(ToDoItem(title: "Sample Task 2"))
	context.insert(ToDoItem(title: "Sample Task 3"))
	context.insert(ToDoItem(title: "Sample Task 4"))
	context.insert(ToDoItem(title: "Sample Task 5"))
	
	return TodoAddItemView()
		.modelContainer(container)
		.environment(GlobalVM())
}

