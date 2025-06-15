//
//  MoodEntry.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/22/25.
//

import Foundation
import SwiftData

@Model
class MoodEntry {
    var dateCreated: Date
    var mood: Mood
    var journal: String
	var flower: Flower?
	

	init(dateCreated: Date, mood: Mood, journal: String, flower: Flower? = nil) {
		self.dateCreated = dateCreated
		self.mood = mood
		self.journal = journal
		self.flower = flower
	}
}

// MARK: What's needed
/// Date Created
/// Mood
/// Journal Entry
/// Flower Type based on mood
/// has Been Watered
