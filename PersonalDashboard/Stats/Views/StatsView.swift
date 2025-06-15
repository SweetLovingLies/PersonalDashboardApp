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
				VStack(alignment: .leading, spacing: 20) {
					StatCard(title: "# of Sessions", value: "\(statsVM.totalPomodoroSessions)", icon: "timer")
					StatCard(title: "Total Time Worked", value: formatTime(statsVM.totalTimeWorked), icon: "clock")
					StatCard(title: "Avg Sessions / Day", value: String(format: "%.1f", statsVM.averageSessionsPerDay), icon: "calendar")
				}
				.padding()
			}
		}
		.onAppear {
			statsVM.loadData()
		}
	}

	func formatTime(_ interval: TimeInterval) -> String {
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
