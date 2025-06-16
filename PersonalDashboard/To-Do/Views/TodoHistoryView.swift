//
//  TodoHistoryView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/15/25.
//

import SwiftUI
import SwiftData

struct TodoHistoryView: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(GlobalVM.self) private var globalVM
	@StateObject private var vm = TodoViewModel()
	
	@Query(sort: \ToDoItem.sortOrder) var todoItems: [ToDoItem]
	init() {
		_todoItems = Query(filter: #Predicate {
			$0.isCompleted == true
		})
	}
	
    var body: some View {
		ZStack {
			globalVM.currentTheme.color(for: .mainBG)
				.ignoresSafeArea()
			
			VStack(spacing: 0) {
				ZStack {
					globalVM.currentTheme.color(for: .headerBG)
						.ignoresSafeArea()
					
					Text("History")
						.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.headerFontSize))
							.foregroundStyle(globalVM.currentTheme.color(for: .textHeader))
				}
				.frame(height: GlobalVM.headerHeight)
				
				// MARK: Toolbar
					if vm.showToolbar {
						ZStack() {
							globalVM.currentTheme.color(for: .accent1)
							
							HStack {
								Button(action: {
									for item in todoItems {
										modelContext.delete(item)
										try? modelContext.save()
									}
								}) {
									Text("Clear")
								}
								.buttonStyle(.borderedProminent)
								.padding(.leading, 10)
								.tint(globalVM.currentTheme.color(for: .accent3))
								.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.buttonFontSize))
								.foregroundStyle(.red)
								
								Spacer()
								
								EditButton()
									.buttonStyle(.borderedProminent)
									.tint(globalVM.currentTheme.color(for: .accent3))
									.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.buttonFontSize))
									.foregroundStyle(globalVM.currentTheme.color(for: .textSecondary))
									.padding(.trailing, 10)
							}
						}
						.frame(height: 50)
						.transition(.move(edge: .top))
						.zIndex(-1) // Forces the bar behind the header
					}
				
				// MARK: Button
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
						.animation(nil, value: vm.showToolbar)
					}
					.buttonStyle(RawButtonStyle())
					
					Spacer()
				}
				.padding(.horizontal, 10)
				
				if todoItems.isEmpty {
					let completedVille = ToDoItem(title: "It's so lonely over here in Completedville...", )
					
					List {
						ToDoItemView(todoItem: completedVille)
							.listRowSeparator(.hidden)
							.listRowBackground(Color.clear)
							.onAppear{
								completedVille.isCompleted = true
								completedVille.completedAt = .distantPast
							}
					}
					.listStyle(.plain)
					.listRowSpacing(20)
					.scrollContentBackground(.hidden)
		
				} else {
					List(todoItems, id: \.self) { item in
						ToDoItemView(todoItem: item)
							.listRowSeparator(.hidden)
							.listRowBackground(Color.clear)
							.onTapGesture {
								item.isCompleted.toggle()
								item.completedAt = nil
							}
					}
					.listStyle(.plain)
					.listRowSpacing(20)
					.scrollContentBackground(.hidden)
				}
				
				Spacer()
			}
		}
    }
}

#Preview {
    TodoHistoryView()
		.environment(GlobalVM())
		.environmentObject(TodoViewModel())
}
