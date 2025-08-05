//
//  MoodTypes.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/7/25.
//

import Foundation

struct Mood: Codable, Hashable {
	let moodOption: MoodOption
	let moodType: MoodTypes
}

extension Mood {
	static let placeholder = Mood(moodOption: .scrollToPick, moodType: .neutral)
	static let happy = Mood(moodOption: .happy, moodType: .positive)
	static let sad = Mood(moodOption: .sad, moodType: .negative)
	static let anxious = Mood(moodOption: .anxious, moodType: .negative)
	static let excited = Mood(moodOption: .excited, moodType: .positive)
	static let tired = Mood(moodOption: .tired, moodType: .neutral)
	static let motivated = Mood(moodOption: .motivated, moodType: .positive)
	static let stressed = Mood(moodOption: .stressed, moodType: .negative)
	static let relaxed = Mood(moodOption: .relaxed, moodType: .balanced)
	static let hopeful = Mood(moodOption: .hopeful, moodType: .positive)
	static let frustrated = Mood(moodOption: .frustrated, moodType: .negative)
	static let calm = Mood(moodOption: .calm, moodType: .positive)
	static let grateful = Mood(moodOption: .grateful, moodType: .positive)
	static let overwhelmed = Mood(moodOption: .overwhelmed, moodType: .negative)
	static let focused = Mood(moodOption: .focused, moodType: .balanced)
	static let joyful = Mood(moodOption: .joyful, moodType: .positive)
	static let melancholy = Mood(moodOption: .melancholy, moodType: .negative)
	static let creative = Mood(moodOption: .creative, moodType: .positive)
	static let lonely = Mood(moodOption: .lonely, moodType: .negative)
	static let confident = Mood(moodOption: .confident, moodType: .positive)
	static let scattered = Mood(moodOption: .scattered, moodType: .negative)
	static let peaceful = Mood(moodOption: .peaceful, moodType: .positive)
	static let inspired = Mood(moodOption: .inspired, moodType: .positive)
	static let burntOut = Mood(moodOption: .burntOut, moodType: .negative)
	static let loved = Mood(moodOption: .loved, moodType: .positive)
	static let content = Mood(moodOption: .content, moodType: .neutral)
	static let energetic = Mood(moodOption: .energetic, moodType: .positive)
	static let reflective = Mood(moodOption: .reflective, moodType: .balanced)
	static let curious = Mood(moodOption: .curious, moodType: .balanced)
	static let nostalgic = Mood(moodOption: .nostalgic, moodType: .balanced)
	static let playful = Mood(moodOption: .playful, moodType: .positive)

	static var allMoods: [Mood] {
		[
			placeholder, happy, sad, anxious, excited, tired, motivated, stressed, relaxed, hopeful,
			frustrated, calm, grateful, overwhelmed, focused, joyful, melancholy, creative,
			lonely, confident, scattered, peaceful, inspired, burntOut, loved, content,
			energetic, reflective, curious, nostalgic, playful
		]
	}
}


