//
//  StatsView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//


import SwiftUI
import Charts

struct StatsView: View {
	@Environment(StatsVM.self) private var statsVM
	@Environment(GlobalVM.self) private var globalVM

	var body: some View {
		VStack {
			// MARK: Header
			ZStack {
				globalVM.currentTheme.color(for: .headerBG)
					.ignoresSafeArea()
				
					Text("Stats")
					.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.headerFontSize))
						.foregroundStyle(globalVM.currentTheme.color(for: .textHeader))
			}
			.frame(height: GlobalVM.headerHeight)
			
			ScrollView {
				Section(
					header:
						HStack {
							Text("Pomodoro Stats")
							
							VStack(spacing: 0) {
								Rectangle()
									.frame(height: 2)
									.foregroundStyle(globalVM.currentTheme.colorScheme == .dark ? .white : .midnightSlate)
								Rectangle()
									.frame(height: 3)
									.foregroundStyle(globalVM.currentTheme.color(for: .accent1))
								Rectangle()
									.frame(height: 2)
									.foregroundStyle(globalVM.currentTheme.colorScheme == .dark ? .white : .midnightSlate)
							}
						}
							.font(.custom(globalVM.currentTheme.lightFont, size: GlobalVM.sectionFontSize))
							.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
							.frame(maxWidth: .infinity, alignment: .leading)

				) {
					VStack(spacing: 20) {
						StatCard(title: "# of Sessions", value: "\(statsVM.totalPomodoroSessions)", icon: "timer")
						StatCard(title: "Total Time Worked", value: formatTime(statsVM.totalTimeWorked), icon: "clock")
						StatCard(title: "Avg Sessions / Day", value: String(format: "%.1f", statsVM.averageSessionsPerDay), icon: "calendar.day.timeline.left")
						StatCard(title: "Current Timer Streak", value: String(statsVM.pomoStreaks.current), icon: "calendar.badge.clock")
						StatCard(title: "Longest Timer Streak", value: String(statsVM.pomoStreaks.longest), icon: "calendar.badge.checkmark")
					}
					Section(
						header:
							HStack {
								Text("To-Do Stats")
								
								VStack(spacing: 0) {
									Rectangle()
										.frame(height: 2)
										.foregroundStyle(globalVM.currentTheme.colorScheme == .dark ? .white : .midnightSlate)
									Rectangle()
										.frame(height: 3)
										.foregroundStyle(globalVM.currentTheme.color(for: .accent1))
									Rectangle()
										.frame(height: 2)
										.foregroundStyle(globalVM.currentTheme.colorScheme == .dark ? .white : .midnightSlate)
								}
							}
								.font(.custom(globalVM.currentTheme.lightFont, size: GlobalVM.sectionFontSize))
								.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
								.frame(maxWidth: .infinity, alignment: .leading)
					) {
						VStack(spacing: 20) {
							StatCard(title: "To-do Tasks Completed", value: "\(statsVM.totalTasksCompleted)", icon: "checkmark.square.fill")
							StatCard(title: "Daily Task Completion Average", value: String(format: "%.1f", statsVM.averageTasksCompletedPerDay), icon: "calendar.day.timeline.left")
							StatCard(title: "Current To-do Streak", value: String(statsVM.taskStreaks.current), icon: "checklist.unchecked")
							StatCard(title: "Longest To-do Streak", value: String(statsVM.taskStreaks.longest), icon: "checklist.checked")
						}
					}
				}
				.padding()
			}
		}
		.onAppear {
			statsVM.loadData()
		}
	}

	private func formatTime(_ interval: TimeInterval) -> String {
		let hours = Int(interval) / 3600
		let minutes = (Int(interval) % 3600) / 60
		let seconds = Int(interval) % 60

		if hours > 0 {
			return "\(hours)h \(minutes)m"
		} else if minutes > 0 {
			return "\(minutes)m \(seconds)s"
		} else {
			return "\(seconds)s"
		}
	}
}
