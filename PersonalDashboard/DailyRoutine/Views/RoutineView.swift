//
//  RoutineView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 8/23/25.
//

import SwiftUI
import SwiftData

struct RoutineView: View {
    @Environment(\.modelContext) var modelContext
    @Query var routineItems: [RoutineItem]
	
	@Environment(GlobalVM.self) private var globalVM
	
	@State private var vm = ViewModel()
	
    var body: some View {
		ZStack {
			VStack {
				ZStack {
					globalVM.currentTheme.color(for: .headerBG)
						.ignoresSafeArea()
					
					Text("To-Do")
						.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.headerFontSize))
							.foregroundStyle(globalVM.currentTheme.color(for: .textHeader))
				}
				.frame(height: GlobalVM.headerHeight)
				
				List {
					ForEach(routineItems) { item in
						HStack {
							Text(item.title)
							Spacer()
							Button {
								item.isCompletedToday.toggle()
								try? modelContext.save()
							} label: {
								Image(systemName: item.isCompletedToday ? "checkmark.circle.fill" : "circle")
							}
						}
					}
				}
			}
		}
        .onAppear {
//			vm.resetRoutineIfNeeded(routineItems: routineItems)
//			try? modelContext.save()
        }
    }
}

extension RoutineView {
	final class ViewModel: ObservableObject {
		func resetRoutineIfNeeded(routineItems: [RoutineItem]) {
			let today = Calendar.current.startOfDay(for: Date())
			
			for item in routineItems {
				let lastCompleted = item.completedDate ?? Date.distantPast
				if Calendar.current.startOfDay(for: lastCompleted) < today {
					item.isCompletedToday = false
				}
			}
		}
		
		func scheduleReminder(for item: RoutineItem) {
			guard let time = item.reminderTime else { return }
			
			let content = UNMutableNotificationContent()
			content.title = "Routine Reminder"
			content.body = "Make sure to complete \(item.title)"
			content.sound = .default
			
			let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: time)
			let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
			
			let request = UNNotificationRequest(identifier: item.id.uuidString, content: content, trigger: trigger)
			
			UNUserNotificationCenter.current().add(request)
		}

	}
}
