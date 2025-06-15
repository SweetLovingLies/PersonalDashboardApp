//
//  GrowthStage.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/12/25.
//

import Foundation

enum GrowthStage: String, Codable {
	case seed
	case sprout
	case flowering
	case mature
	
	func nextStage(daysSincePlanting: Int) -> GrowthStage {
		switch self {
		case .seed where daysSincePlanting >= 1:
			return .sprout
		case .sprout where daysSincePlanting >= 3:
			return .flowering
		case .flowering where daysSincePlanting >= 5:
			return .mature
		default:
			return self
		}
	}
	
	func ageState() -> String {
		switch self {
		case .seed:
			return "Just a seed"
		case .sprout:
			return "Starting to Sprout"
		case .flowering:
			return "Beginning to flower"
		case .mature:
			return "Matured"
		}
	}
}
