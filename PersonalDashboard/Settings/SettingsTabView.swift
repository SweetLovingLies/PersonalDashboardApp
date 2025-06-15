//
//  SettingsTabView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/27/25.
//

import SwiftUI

enum settingsTypes {
	case settings
	case themeSwitcher
}

struct SettingsTabView: View {
	@Environment(GlobalVM.self) private var globalVM
	@State var selectedTab: settingsTypes = .themeSwitcher
	
    var body: some View {
		ZStack {
			TabView(selection: $selectedTab) {
				SettingsView()
					.tabItem {
						Label("Settings", systemImage: "gearshape.fill")
					}
					.tag(settingsTypes.settings)
				
				
				
				ThemeSwitcher()
					.tabItem {
						Label("Themeswitcher", image: "custom.cloud")
					}
					.tag(settingsTypes.themeSwitcher)
			}
			.tint(globalVM.currentTheme.color(for: .accent1))
			.onAppear {
				UITabBar.appearance().unselectedItemTintColor = globalVM.currentTheme.colorScheme == .dark ? UIColor.white : UIColor.gray
			}
		}
    }
}

#Preview {
    SettingsTabView()
		.environment(GlobalVM())
}
