//
//  MainButtonStyle.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/4/25.
//

import SwiftUI

struct MainButtonStyle: ViewModifier {
	var gradientColor1: Color
	var gradientColor2: Color?
	var fontColor: Color
	var strokeColor: Color
	var font: String
		
	private let strokeWidth: CGFloat = 4
	
//	private var dropShadow1: CGFloat {
//		return strokeWidth - 3
//	}
//	private var dropShadow2: CGFloat {
//		return strokeWidth + 2
//	}
	
	private var fillStyle: AnyShapeStyle {
		if let gradientColor2 {
			return AnyShapeStyle(
				LinearGradient(colors: [gradientColor1, gradientColor2], startPoint: .top, endPoint: .bottom)
			)
		} else {
			return AnyShapeStyle(gradientColor1)
		}
	}
	
	func body(content: Content) -> some View {
		ZStack {
			content
				.bold()
				.font(.custom(font, size: 14))
				.foregroundStyle(fontColor)
				.font(.headline)
				.padding(.vertical)
				.padding(.horizontal, 30)
			
			
			// Main Background
			
				.background(
					Capsule()
						.fill(fillStyle)
				)
			
			// Drop Shadows
			//				.background(
			//					Capsule()
			//						.fill(.gray)
			//						.offset(y: dropShadow1)
			//				)
			//				.background(
			//					Capsule()
			//						.fill(.cupcake)
			//						.offset(y: dropShadow2)
			//				)
			
			// Stroke
				.overlay(
					Capsule()
						.stroke(strokeColor, lineWidth: strokeWidth)
				)
			
			// Stroke Overlays
			
			// Dot Shine 1
				.overlay(
					Capsule()
						.foregroundStyle(.white)
						.frame(width: 10, height: 8)
						.offset(x: 17, y: -24)
				)
			
			// Dot Shine 2
				.overlay(
					Capsule()
						.foregroundStyle(.white)
						.frame(width: 7, height: 5)
						.offset(x: 29, y: -24)
				)
			
			
			// Shine Overlay
				.overlay(
					Capsule()
						.foregroundStyle(
							LinearGradient(colors: [.white.opacity(0.3), .clear], startPoint: .top, endPoint: .bottom)
						)
						.padding(10)
						.allowsHitTesting(false)
				)
			
				.padding(4)
		}
		.clipShape(
			Capsule()
		)

	}
}

#Preview {
	ZStack {
		Color.gray.ignoresSafeArea()
		
		
		Text("Hello, World!")
			.mainButtonStyle(gradientColor1: .matchaCream, gradientColor2: .teaPaper, fontColor: .black, strokeColor: .dollNight, font: "Fredoka-Medium")
	}
}
