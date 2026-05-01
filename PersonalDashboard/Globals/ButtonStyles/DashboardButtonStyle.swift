//
//  DashboardIcon.swift
//  DashboardApp
//
//  Created by Morgan Harris on 5/18/25.
//


import SwiftUI


struct DashboardButtonStyle: ButtonStyle {
	let isSelected: Bool
	let globalVM: GlobalVM

	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.font(.system(size: 27))
			.frame(width: 30, height: 30)
			.padding(10)
			.background(isSelected ? globalVM.currentTheme.color(for: .accent1) : globalVM.currentTheme.color(for: .accent3).opacity(0.2))
			.foregroundStyle(isSelected ? globalVM.currentTheme.color(for: .textSecondary) : globalVM.currentTheme.color(for: .textPrimary))
			.clipShape(RoundedRectangle(cornerRadius: 15))
			.shadow(radius: isSelected ? 5 : 0)
			.scaleEffect(configuration.isPressed ? 0.75 : 1)
			.animation(.spring(response: 0.3, dampingFraction: 0.3), value: configuration.isPressed)
	}
}
