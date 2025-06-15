//
//  MainTabContainer.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/15/25.
//

import SwiftUI

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
				case .notes:
					NotesView()
				case .settings:
					SettingsTabView()
				}
			}
			.environmentObject(navController)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(globalVM.currentTheme.color(for: .mainBG))

			NavigationBar(currentSection: $currentSection)
		}
		.ignoresSafeArea(.keyboard)
	}
}
