//
//  FocusCategory.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 8/23/25.
//

import Foundation

enum FocusCategory: String, CaseIterable, Codable, Identifiable {
	case selectOne = "Select a Catagory"
    case code = "Code"
    case art = "Art"
    case reading = "Reading"
    case writing = "Writing"
    case other = "Other"

    var id: String { rawValue }
	
	var focusLine: String {
		switch self {
		case .code:
			return "Remember, we're trying to get better at coding!"
		case .art:
			return "Keep drawing! It's the best way to get better!"
			case .reading:
			return "What are you reading? Is it good?"
		case .writing:
			return "Writing is meant to calm your thoughts. Is it doing that for you?"
		case .other:
			return "No phubbing! It's time to lock in!"
		default:
			return ""
		}
	}
}
