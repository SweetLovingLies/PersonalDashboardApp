//
//  PomodoroStateButtonStyle.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftUI


struct PomodoroStateButtonStyle: ButtonStyle {
	let globalVM: GlobalVM
	let color: Color
	var isEnabled: Bool = true
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
			.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.midTitleFontSize))
			.frame(width: 120, height: 66)
			.background(isEnabled ? (configuration.isPressed ? color.opacity(0.6) : color) : color.opacity(0.3))
			.clipShape(RoundedRectangle(cornerRadius: GlobalVM.cornerRadiusSmall))
			.opacity(isEnabled ? 1.0 : 0.4)
	}
}
