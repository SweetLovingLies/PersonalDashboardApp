//
//  ChatBubbleStyle.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/20/25.
//

import SwiftUI

struct ChatBubbleStyle : ViewModifier {
	let globalVM: GlobalVM
	
	func body(content: Content) -> some View {
		content
			.foregroundStyle(globalVM.currentTheme.color(for: .accent2))
			.clipShape(RoundedRectangle(cornerRadius: 30))
			.overlay(RoundedRectangle(cornerRadius: 30).stroke(globalVM.currentTheme.color(for: .accent1), lineWidth: 5))
		
	}
}
