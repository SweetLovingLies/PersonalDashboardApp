//
//  NavigationBar.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/21/25.
//

import SwiftUI

struct NavigationBar: View {
	@Environment(GlobalVM.self) private var globalVM
	@Binding var currentSection: NavSection
	@State private var isMenuShowing: Bool = false
	
    var body: some View {
		HStack(spacing: 0) {
			Spacer()
			
			// MARK: MAIN
			HStack(alignment: .center, spacing: 0) {
				
				// MARK: Heart Indicator
				ZStack(alignment: .leading) {
					Rectangle()
						.foregroundStyle(.ultraThinMaterial)
						.frame(width: 30, height: 20)
					
					Image(systemName: "heart.fill")
						.foregroundStyle(globalVM.currentTheme.color(for: .accent1))
						.font(.system(size: 50))
						.rotationEffect(.degrees(isMenuShowing ? 90 : 0))
						.offset(x: -5, y: 15)
						.padding(-40)
				}
				.offset(y: -105)
				
				// MARK: NAV BAR
				
				VStack(spacing: 10) {
					Button(action: {currentSection = .landing}) {
						if globalVM.currentTheme.tsIcon.contains("custom") {
							Image(globalVM.currentTheme.tsIcon)
						} else {
							Image(systemName: globalVM.currentTheme.tsIcon)
						}
					}
					.buttonStyle(DashboardButtonStyle(isSelected: currentSection == .landing, globalVM: globalVM))
					
					Button(action: {currentSection = .todo}) {
						Image(systemName: "checkmark.square.fill")
					}
					.buttonStyle(DashboardButtonStyle(isSelected: currentSection == .todo, globalVM: globalVM))
					
					Button(action: {currentSection = .pomodoro}) {
						Image(systemName: "timer.circle.fill")
					}
					.buttonStyle(DashboardButtonStyle(isSelected: currentSection == .pomodoro, globalVM: globalVM))
					
					Button(action: {currentSection = .stats}) {
						Image(systemName: "chart.bar.fill")
					}
					.buttonStyle(DashboardButtonStyle(isSelected: currentSection == .stats, globalVM: globalVM))
					
					Button(action: {currentSection = .settings}) {
						Image(systemName: "gearshape.fill")
					}
					.buttonStyle(DashboardButtonStyle(isSelected: currentSection == .settings, globalVM: globalVM))
					
				}
				.navBarStyle(globalVM: globalVM)
			}
			.shadow(color: globalVM.currentTheme.color(for: .accent1).opacity(0.3), radius: 10)
			
			.offset(x: isMenuShowing ? 20 : 145)
			.animation(.bouncy, value: isMenuShowing)
			.frame(width: 200)
			.onTapGesture {
				isMenuShowing.toggle()
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
		}
		.opacity(isMenuShowing ? 1 : 0.55)
    }
}
