//
//  MainTabContainer.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/15/25.
//

import SwiftUI

/// Switch tabs based on what the current section is. Binded with Navigation Bar
struct MainTabContainer: View {
	@Environment(GlobalVM.self) private var globalVM
	@Binding var currentSection: NavSection
	@EnvironmentObject var navController: NavController
	
	var body: some View {
		ZStack {
			Group {
				switch currentSection {
				case .landing:
					LandingView()
				case .todo:
					TodoView()
				case .pomodoro:
					PomodoroView()
				case .stats:
					StatsView()
				case .settings:
					SettingsTabView()
				case .routine:
					RoutineView()
				}
			}
			.environmentObject(navController)
			.background(globalVM.currentTheme.color(for: .mainBG))

			NavigationBar(currentSection: $currentSection)
		}
		.ignoresSafeArea(.keyboard)
	}
}
