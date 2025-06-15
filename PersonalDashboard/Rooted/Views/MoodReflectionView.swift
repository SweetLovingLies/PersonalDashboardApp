//
//  MoodReflectionView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/22/25.
//
//

import SwiftUI
import SwiftData

struct MoodReflectionView: View {
	@Environment(GlobalVM.self) private var globalVM
	@EnvironmentObject var navController: NavController
	let mood: Mood
	@State private var vm: ViewModel

	init(mood: Mood) {
		self.mood = mood
		self._vm = State(initialValue: ViewModel(mood: mood))
	}

	var body: some View {
		ZStack {
			globalVM.currentTheme.color(for: .mainBG).ignoresSafeArea()
			Color.blue.opacity(0.2).ignoresSafeArea()
			
			VStack {
				ZStack {
					switch vm.timeOfDay {
					case "day":
						Color.bubbles.ignoresSafeArea()
						
					case "night":
						Color.dollNight.ignoresSafeArea()
						
					default:
						Color.lillium.ignoresSafeArea()
					}
					
					Text("Reflection")
						.font(.custom("Fredoka-Medium", size: GlobalVM.headerFontSize))
						.foregroundStyle(vm.timeOfDay == "night" ? .white : .black)
					
					switch vm.timeOfDay {
					case "night":
						Image(systemName: "moon.fill")
							.foregroundStyle(.amberLight)
							.font(.system(size: 60))
							.offset(x: -150)
						
					case "day":
						Image(systemName: "sun.max.fill")
							.foregroundStyle(.starshine)
							.font(.system(size: 60))
							.offset(x: 160)
						
					default:
						Image(systemName: "sun.max.fill")
							.foregroundStyle(.starshine)
							.font(.system(size: 60))
							.offset(x: -150)
					}
					
				}
				.frame(height: GlobalVM.headerHeight)
				
				VStack {
					Text(vm.feelingText)
						.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.smallTitleFontSize))
						.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
					
					ZStack(alignment: .topLeading) {
						TextEditor(text: $vm.journalText)
							.textEditorStyle(.plain)
							.padding()
							.background(.ultraThinMaterial)
							.clipShape(RoundedRectangle(cornerRadius: 10))
							.tint(globalVM.currentTheme.color(for: .accent1))
						
						Text("Would you like to speak to why you are feeling this way?")
							.font(.custom("Fredoka-Medium", size: GlobalVM.bodyFontSize))
							.opacity(vm.journalText.isEmpty ?	0.5 : 0)
							.padding(25)
					}
					
					Button(action: {
						let moodEntry = MoodEntry(
							dateCreated: .now,
							mood: mood,
							journal: vm.journalText
						)
						navController.navigate(to: .seedGet(entry: moodEntry))
					}) {
						Text("Save")
					}
					.mainButtonStyle(
						gradientColor1: .whisper,
						fontColor: vm.journalText.isEmpty ? .gray : .black,
						strokeColor: .mistyRose,
						font: globalVM.currentTheme.bodyFont
					)
					.disabled(vm.journalText.isEmpty)

				}
				.padding()
				
				Spacer()
				
			}
		}
//		.navigationBarBackButtonHidden()
	}
}

extension MoodReflectionView {
	@Observable
	final class ViewModel {
		var journalText: String
		let mood: Mood

		
		var timeOfDay: String {
			let hour = Calendar.current.component(.hour, from: Date())
						
			// 12 - 5am or 4 - 8pm
			if hour >= 0 && hour < 5 || hour >= 17 && hour < 20 {
				return "transitional"
				// 5am - 5pm
			} else if hour >= 5 && hour < 17 {
				return "day"
				// 8pm to 12am
			} else {
				return "night"
			}
		}
		
		var feelingText: String {
			switch mood.moodType {
			case .positive:
				return "Wonderful! Feeling \(mood.moodOption.rawValue.lowercased()) will allow us to be productive today!"
			case .negative:
				return "It's always gloomy in \(mood.moodOption.rawValue)-ville..."
			case .neutral:
				return "Sometimes, we're feeling \(mood.moodOption.rawValue.lowercased()), and that's ok!"
			case .balanced:
				return "Feeling \(mood.moodOption.rawValue.lowercased()) will allow for an easier day."
			}
		}
		
		init(journalText: String = "", mood: Mood) {
			self.journalText = journalText
			self.mood = mood
		}
	}
}

#Preview {
	MoodReflectionView(mood: .happy)
		.environment(GlobalVM())
		.environmentObject(NavController())
}
