//
//  ViewExtensions.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftUI

extension View {
	func navBarStyle(globalVM: GlobalVM) -> some View {
		self.modifier(NavBarStyle(globalVM: globalVM))
	}
	
	func chatBubbleStyle(globalVM: GlobalVM) -> some View {
		self.modifier(ChatBubbleStyle(globalVM: globalVM))
	}
	
	func shadowOutlineStyle(
		color: Color = .black,
		radius: CGFloat = 0,
		range: CGFloat = 1
	) -> some View {
		self.modifier(ShadowOutlineStyle(color: color, radius: radius, range: range))
	}
	
	func mainButtonStyle(gradientColor1: Color, gradientColor2: Color? = nil, fontColor: Color, strokeColor: Color, font: String) -> some View {
		self.modifier(MainButtonStyle(gradientColor1: gradientColor1, gradientColor2: gradientColor2, fontColor: fontColor, strokeColor: strokeColor, font: font))
	}
}
