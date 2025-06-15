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
	@Environment(TodoViewModel.self) private var todoVM
	
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
			
			VStack {
				ZStack {
					globalVM.currentTheme.color(for: .headerBG)
						.ignoresSafeArea()
					
					Text("History")
						.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.headerFontSize))
							.foregroundStyle(globalVM.currentTheme.color(for: .textHeader))
				}
				.frame(height: GlobalVM.headerHeight)
				
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
				
				Spacer()
			}
		}
    }
}

#Preview {
    TodoHistoryView()
		.environment(GlobalVM())
		.environment(TodoViewModel())
}
