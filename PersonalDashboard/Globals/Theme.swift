//
//  Theme.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftUI

enum ColorPalette: String, Codable {
	case coquette
	case summer
	case eveningsInWinter
	case nightOwl
	case magicalGirl
	case apothecaryGirl
	case femmeFatale
}

enum ThemeColorRole: Codable {
	case mainBG
	case headerBG
	case accent1
	case accent2
	case accent3
	case textHeader
	case textPrimary
	case textSecondary
	case textFieldPlaceholder
}

enum themeColorScheme: Codable {
	case dark
	case light
}

struct Theme: Identifiable, Equatable {
	let id = UUID()
	let colorPalette: ColorPalette
	let headerFont: String
	let bodyFont: String
	let lightFont: String
	let tsIcon: String
	let tsBG: String
	let colorScheme: themeColorScheme
	
	private let colorMap: [ThemeColorRole: Color]
	
	func color(for role: ThemeColorRole) -> Color {
		colorMap[role] ?? .black // default fallback if not defined
	}
	
	static func from(colorPalette: ColorPalette) -> Theme {
		return all.first(where: { $0.colorPalette == colorPalette }) ?? .coquette
	}
	
	
	
	// MARK: - My Themes
	static let coquette = Theme(
		colorPalette: .coquette,
		headerFont: "Merriweather-Bold",
		bodyFont: "Merriweather-Regular",
		lightFont: "Merriweather-Light",
		tsIcon: "heart.fill",
		tsBG: "coquetteBG",
		colorScheme: .light,
		colorMap: [
			.mainBG: .mistyRose,
			.headerBG: .resedaGreen,
			.accent1: .blush,
			.accent2: .desertSand,
			.accent3: .sweetViolet,
			.textHeader: .white,
			.textPrimary: .black,
			.textSecondary: .white,
			.textFieldPlaceholder: .gray
		]
	)
	
	static let summer = Theme(
		colorPalette: .summer,
		headerFont: "Fredoka-Medium",
		bodyFont: "Fredoka-Regular",
		lightFont: "Fredoka-Light",
		tsIcon: "custom.hibiscus",
		tsBG: "summerBG",
		colorScheme: .light,
		colorMap: [
			.mainBG: .waveCaps,
			.headerBG: .seaGreen,
			.accent1: .flamingo,
			.accent2: .beachSand,
			.accent3: .hibiscus,
			.textHeader: .white,
			.textPrimary: .black,
			.textSecondary: .white,
			.textFieldPlaceholder: .black
		]
	)
	
	static let eveningsInWinter = Theme(
		colorPalette: .eveningsInWinter,
		headerFont: "Merriweather-Bold",
		bodyFont: "Merriweather-Regular",
		lightFont: "Merriweather-Light",
		tsIcon: "snowflake",
		tsBG: "winterBG",
		colorScheme: .light,
		colorMap: [
			.mainBG: .iceRose,
			.headerBG: .midnightSlate,
			.accent1: .firBranch,
			.accent2: .yuki,
			.accent3: .amberLight,
			.textHeader: .white,
			.textPrimary: .black,
			.textSecondary: .white,
			.textFieldPlaceholder: .black
			]
		)
	
	static let nightOwl = Theme(
		colorPalette: .nightOwl,
		headerFont: "Kansei-Regular",
		bodyFont: "Orbitron-Medium",
		lightFont: "Orbitron-Regular",
		tsIcon: "custom.music",
		tsBG: "neonBG",
		colorScheme: .dark,
		colorMap: [
			.mainBG: .urbanSky,
			.headerBG: .dollNight,
			.accent1: .neonPink,
			.accent2: .violetLight,
			.accent3: .sunDown,
			.textHeader: .white,
			.textPrimary: .white,
			.textSecondary: .black,
			.textFieldPlaceholder: .white
			]
		)
	
	static let magicalGirl = Theme(
		colorPalette: .magicalGirl,
		headerFont: "Fredoka-Medium",
		bodyFont: "Fredoka-Regular",
		lightFont: "Fredoka-Light",
		tsIcon: "star.fill",
		tsBG: "dreamBG",
		colorScheme: .light,
		colorMap: [
			.mainBG: .whisper,
			.headerBG: .bubbles,
			.accent1: .lillium,
			.accent2: .cupcake,
			.accent3: .starshine,
			.textHeader: .black,
			.textPrimary: .black,
			.textSecondary: .black,
			.textFieldPlaceholder: .black
			]
		)
	
	static let apothecaryGirl = Theme(
		colorPalette: .apothecaryGirl,
		headerFont: "PlaypenSans-SemiBold",
		bodyFont: "PlaypenSans-Regular",
		lightFont: "PlaypenSans-Light",
		tsIcon: "custom.mushroom",
		tsBG: "mushroomBG",
		colorScheme: .dark,
		colorMap: [
			.mainBG: .weatheredBark,
			.headerBG: .matchaCream,
			.accent1: .foolsGold,
			.accent2: .pickedPlum,
			.accent3: .teaPaper,
			.textHeader: .black,
			.textPrimary: .white,
			.textSecondary: .black,
			.textFieldPlaceholder: .white
		]
	)
	
	static let femmeFatale = Theme(
		colorPalette: .femmeFatale,
		headerFont: "Didot",
		bodyFont: "AmericanTypewriter",
		lightFont: "AmericanTypewriter-Light",
		tsIcon: "custom.dagger",
		tsBG: "redMoonBG",
		colorScheme: .dark,
		colorMap: [
			.mainBG: .garnetNoir,
			.headerBG: .velvetMerlot,
			.accent1: .demonsKiss,
			.accent2: .porcelainRose,
			.accent3: .fatalBlusher,
			.textHeader: .white,
			.textPrimary: .white,
			.textSecondary: .black,
			.textFieldPlaceholder: .white
		]
	)
	
	
	static let all: [Theme] = [.coquette, .summer, .eveningsInWinter, .nightOwl, .magicalGirl, .apothecaryGirl, .femmeFatale]
}
