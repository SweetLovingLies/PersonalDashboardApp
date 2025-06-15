//
//  SettingsView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/27/25.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
	@Environment(GlobalVM.self) private var globalVM
	
	var body: some View {
		VStack {
			ZStack {
				globalVM.currentTheme.color(for: .mainBG).ignoresSafeArea()
				
				VStack {
					// MARK: Header
					ZStack {
						globalVM.currentTheme.color(for: .headerBG)
							.ignoresSafeArea()
						
							Text("Settings")
							.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.headerFontSize))
							.foregroundStyle(globalVM.currentTheme.color(for: .textHeader))
					}
					.frame(height: GlobalVM.headerHeight)
					
					// MARK: List
					VStack(alignment: .leading) {
						Section(header:
								Text("Notifications")
								.font(.custom(globalVM.currentTheme.lightFont, size: GlobalVM.sectionFontSize))
								.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
						) {
							Button(action: {
								UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
									if success {
										print("All set!")
									} else if let error {
										print(error.localizedDescription)
									}
								}
							}) {
								Text("Request Permissions")
									.font(.custom(globalVM.currentTheme.bodyFont, size: 18, relativeTo: .body))

								
								Spacer()
							}
							.buttonStyle(SettingsButtonStyle(bgColor: globalVM.currentTheme.color(for: .accent1), fontColor: globalVM.currentTheme.color(for: .textPrimary), decorColor: globalVM.currentTheme.color(for: .accent3)))
						}
					}
					.padding()
					
					
					Spacer()
				}
			}
		}
	}
}

#Preview {
	SettingsView()
		.environment(GlobalVM())
}
