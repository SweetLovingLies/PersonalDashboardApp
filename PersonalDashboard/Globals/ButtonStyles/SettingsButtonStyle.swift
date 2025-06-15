//
//  SettingsButtonStyle.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/4/25.
//

import SwiftUI

struct SettingsButtonStyle: ButtonStyle {
	var bgColor: Color
	var fontColor: Color
	var decorColor: Color
	
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			Spacer()
			
			Image(systemName: "heart")
				.foregroundStyle(decorColor)
			
			Spacer()
			
			Rectangle()
				.frame(width: 2)
				.foregroundStyle(decorColor)
			
			configuration.label
				.foregroundStyle(fontColor)
			
			Rectangle()
				.frame(width: 2)
				.foregroundStyle(decorColor)
			
			Spacer()
			
			Image(systemName: "heart")
				.foregroundStyle(decorColor)
			
			Spacer()
		}
		.frame(height: 40)
		.background(configuration.isPressed ? Color.pastel() : bgColor)
		.clipShape(.rect(cornerRadius: 10))
			
	}
}
