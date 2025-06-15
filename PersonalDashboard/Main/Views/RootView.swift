//
//  RootView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftUI
import SwiftData

struct RootView: View {
	@Environment(\.modelContext) private var modelContext
	@EnvironmentObject var navController: NavController

	var body: some View {
		MainView()
			.environment(GlobalVM())
			.environment(StatsVM(context: modelContext))
			.environmentObject(navController)
	}
}
