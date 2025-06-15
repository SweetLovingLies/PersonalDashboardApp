//
//  ShadowOutlineStyle.swift
//  ConvoJo
//
//  Created by Morgan Harris on 5/15/25.
//

import SwiftUI

struct ShadowOutlineStyle: ViewModifier {
	let color: Color
	let radius: CGFloat
	let range: CGFloat
	
	func body(content: Content) -> some View {
		content
			.shadow(color: color, radius: radius, x: range, y: range)
			.shadow(color: color, radius: radius, x: -range, y: range)
			.shadow(color: color, radius: radius, x: -range, y: -range)
			.shadow(color: color, radius: radius, x: range, y: -range)
	}
}


