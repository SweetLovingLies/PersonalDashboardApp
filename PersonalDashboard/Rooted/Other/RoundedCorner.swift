//
//  RoundedCorner.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/15/25.
//

import SwiftUI

struct RoundedCorner: Shape {
	var radius: CGFloat = 15.0
	var corners: [UIRectCorner] = [.topRight]

	func path(in rect: CGRect) -> Path {
		// Properly convert the array into a single UIRectCorner option set
		let cornerMask: UIRectCorner = corners.reduce(UIRectCorner()) { partialResult, next in
			partialResult.union(next)
		}

		let path = UIBezierPath(
			roundedRect: rect,
			byRoundingCorners: cornerMask,
			cornerRadii: CGSize(width: radius, height: radius)
		)
		return Path(path.cgPath)
	}
}

