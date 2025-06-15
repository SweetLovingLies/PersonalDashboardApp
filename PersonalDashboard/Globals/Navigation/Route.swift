//
//  Route.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/12/25.
//


import Foundation

// Only 3 because this will only really be used within the LandingView "GROUP"
enum Route: Hashable {
	case reflection(selectedMood: Mood)
	case seedGet(entry: MoodEntry)
	case garden
	case wateringTransition(seed: MoodEntry)
}
