//
//  PomodoroSessionData.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftData
import Foundation

@Model
class PomodoroSessionData: Identifiable {
	var id: UUID
	var date: Date
	var timeWorked: TimeInterval
	var nSessions: Int

	init(timeWorked: TimeInterval, date: Date, nSessions: Int) {
		self.id = UUID()
		self.timeWorked = timeWorked
		self.date = date
		self.nSessions = nSessions
	}
}



// MARK: Thought Processing: What Kind of Data do we want?
/// Total Time Worked: TimeInterval
/// Average Sessions a day: Double ? ? ?
/// Number of Pomodoro Sessions Overall : Int
/// Current Streak : Int
/// Longest Streak : Int
/// Number of To-Do List tasks completed : Int
