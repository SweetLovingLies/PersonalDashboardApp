//
//  LandingViewModel.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/6/25.
//

import Foundation
import UserNotifications

extension LandingView {
	@Observable
	final class ViewModel {
		let affirmations: [String] = [
			"I am doing my best, and that is enough.",
			"I have survived 100% of my worst days.",
			"It's okay to rest. I deserve rest.",
			"I am proud of how far I've come.",
			"My feelings are valid and important.",
			"I trust myself to make the right choices.",
			"I radiate calm and peace.",
			"Mistakes are part of growth.",
			"I don’t need to have it all figured out.",
			"I am more than my productivity.",
			"I choose to be kind to myself today.",
			"I am allowed to take up space.",
			"Progress, not perfection.",
			"I am resilient, strong, and brave.",
			"My future is full of possibilities.",
			"It's okay to ask for help.",
			"I am learning, growing, and evolving.",
			"My worth is not tied to how much I get done.",
			"Every step forward matters, no matter how small.",
			"I bring something special to the world.",
			"I have the strength to keep going.",
			"Today, I will focus on what I can control.",
			"I am becoming someone I can be proud of.",
			"It's okay to not be okay right now.",
			"I give myself permission to feel joy.",
			"My presence makes a difference.",
			"I am safe in my body and my mind.",
			"Even small victories count.",
			"I am worthy of love, care, and attention.",
			"I have what it takes to get through today.",
			"I can be soft and strong at the same time.",
			"Slowing down is not the same as giving up.",
			"I am not behind — I am on my own path.",
			"I release the pressure to be perfect.",
			"Good things are coming my way.",
			"I choose patience and progress.",
			"I am capable of great things.",
			"I can take things one moment at a time.",
			"My needs matter just as much as anyone else's.",
			"I deserve to take care of myself.",
			"My thoughts are worthy of love and attention.",
			"Good things are headed my way today.",
			"I am lucky, grateful, and blessed.",
			"Everything that happens today will be for my highest good.",
			"Only good things will come to me as a result of how the day unfolds.",
			"Thank you, Universe, for the beautiful day ahead.",
			"I am a priority.",
			"Every part of me is beautiful.",
			"I am fearless.",
			"There is no one better to be than myself.",
			"I can get through anything.",
			"If I fall, I will get back up again.",
			"Today, I will work through my challenges.",
			"I am open and ready to learn."
		]
		let moods: [Mood] = Mood.allMoods
		var selectedMood: Mood = .happy
		
		func didLogMoodToday(entries: [MoodEntry]) -> Bool {
			let calendar = Calendar.current
			let today = Date()
			
			return entries.contains { entry in
				calendar.isDate(entry.dateCreated, inSameDayAs: today)
			}
		}
		
		func getAffirmationForToday() -> String {
			let calendar = Calendar.current
			let date = Date()
			let dayOfYear = calendar.ordinality(of: .day, in: .year, for: date) ?? 0
			
			// Just rotate through affirmations based on the day
			return affirmations[dayOfYear % affirmations.count]
		}
		
		func make530pmNotification() {
			let hasScheduled = UserDefaults.standard.bool(forKey: "hasScheduled530Notification")
			
			guard !hasScheduled else {
				print("Notification already scheduled.")
				return
			}
			
			let content = UNMutableNotificationContent()
			content.title = "Hey... it's been a while?"
			content.subtitle = "How are you doing? Would you like to check in?"
			content.sound = UNNotificationSound.default
			
			var dateComponents = DateComponents()
			dateComponents.hour = 17
			dateComponents.minute = 30
			
			let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
			
			let request = UNNotificationRequest(identifier: "daily530Notification", content: content, trigger: trigger)
			
			UNUserNotificationCenter.current().add(request) { error in
				if let error = error {
					print("Notification scheduling error: \(error)")
				} else {
					UserDefaults.standard.set(true, forKey: "hasScheduled530Notification")
					print("Notification scheduled for 5:30 PM daily!")
				}
			}
		}
	}
}
