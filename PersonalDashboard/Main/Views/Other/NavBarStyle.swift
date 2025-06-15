//
//  NavBarStyle.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/20/25.
//

import SwiftUI

struct NavBarStyle : ViewModifier {
	let globalVM: GlobalVM
	
	func body(content: Content) -> some View {
		content
		.padding(20)
		.background(.ultraThinMaterial)
		.cornerRadius(30)
		.padding(.trailing, 20)
		.padding(.bottom, 40)
	}
}
