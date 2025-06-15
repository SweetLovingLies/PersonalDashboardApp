//
//  GlobalVM.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import Foundation

@Observable
class GlobalVM {
	static var headerHeight: CGFloat = 70
	static var cornerRadiusLarge: Double = 30
	static var cornerRadiusSmall: Double {
		Double(cornerRadiusLarge / 2)
	}
	
	static var captionFontSize: CGFloat = 12
	static var buttonFontSize: CGFloat = 16
	static var headlineFontSize: CGFloat = 17
	static var bodyFontSize: CGFloat = 18
	static var sectionFontSize: CGFloat = 20
	static var smallTitleFontSize: CGFloat = 20
	static var midTitleFontSize: CGFloat = 24
	static var headerFontSize: CGFloat = 30
	
	private let themeKey = "selectedTheme"
	
	var currentTheme: Theme {
		didSet {
			saveTheme()
		}
	}
	
	private func saveTheme() {
		let raw = currentTheme.colorPalette.rawValue
		UserDefaults.standard.set(raw, forKey: themeKey)
	}

	
	init() {
		// Load from UserDefaults
		if let raw = UserDefaults.standard.string(forKey: themeKey),
		   let palette = ColorPalette(rawValue: raw) {
			self.currentTheme = Theme.from(colorPalette: palette)
			
		} else {
			self.currentTheme = .from(colorPalette: .coquette)
		}
	}

}

