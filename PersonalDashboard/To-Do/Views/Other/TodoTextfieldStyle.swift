//
//  TodoTextfieldStyle.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//


import SwiftUI

struct TodoTextfieldStyle: TextFieldStyle {
	let globalVM: GlobalVM
	func _body(configuration: TextField<Self._Label>) -> some View {
		configuration
			.font(.custom(globalVM.currentTheme.bodyFont, size: 16))
			.padding(10)
			.cornerRadius(5)
			.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
			.tint(globalVM.currentTheme.color(for: .accent1))
			.background(
				VStack {
					Spacer()
					globalVM.currentTheme.color(for: .accent1)
						.frame(height: 2)
				}
			)
	}
}
