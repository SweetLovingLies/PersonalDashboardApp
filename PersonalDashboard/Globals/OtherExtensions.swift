//
//  OtherExtensions.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftUI
import UIKit

extension Array where Element: BinaryFloatingPoint {
	func average() -> Element {
		guard !isEmpty else { return 0 }
		return reduce(0, +) / Element(count)
	}
}

extension Color {
	static func random(randomOpacity: Bool = false) -> Color {
		Color(
			red: .random(in: 0...1),
			green: .random(in: 0...1),
			blue: .random(in: 0...1),
			opacity: randomOpacity ? .random(in: 0...1) : 1
		)
	}
	
	static func pastel(randomOpacity: Bool = false) -> Color {
		let hue = Double.random(in: 0...1)
		let saturation = Double.random(in: 0.4...0.6)
		let brightness = Double.random(in: 0.85...1.0)
		return Color(hue: hue, saturation: saturation, brightness: brightness, opacity: randomOpacity ? .random(in: 0.6...1) : 1)
	}

	// Found on Stack Overflow lol
	
	
	// Convert Color to HEX String
	func toHex() -> String? {
		let uiColor = UIColor(self)
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0
		
		guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
			return nil
		}
		
		let r = Int(red * 255)
		let g = Int(green * 255)
		let b = Int(blue * 255)
		
		return String(format: "#%02X%02X%02X", r, g, b)
	}
	
	// Convert HEX String to Color
	static func fromHex(_ hex: String) -> Color {
		var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		
		if hex.hasPrefix("#") {
			hex.removeFirst()
		}
		
		guard hex.count == 6,
			  let rgb = Int(hex, radix: 16) else {
			return .gray // Fallback
		}
		
		let r = Double((rgb >> 16) & 0xFF) / 255
		let g = Double((rgb >> 8) & 0xFF) / 255
		let b = Double(rgb & 0xFF) / 255
		
		return Color(red: r, green: g, blue: b)
	}
}


extension String {
	func capitalizingFirstLetter() -> String {
		return prefix(1).capitalized + dropFirst()
	}

	mutating func capitalizeFirstLetter() {
		self = self.capitalizingFirstLetter()
	}
}
