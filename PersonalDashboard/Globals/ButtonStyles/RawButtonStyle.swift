//
//  RawButtonStyle.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//
// MARK: Voids the Animations for button clicks. Very helpful as a base.

import SwiftUI

struct RawButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.opacity(1)
			.scaleEffect(1)
	}
}
