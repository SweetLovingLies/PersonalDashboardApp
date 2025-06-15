//
//  SeedGetView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/11/25.
//

import SwiftUI
import SwiftData

struct SeedGetView: View {
	@Environment(GlobalVM.self) private var globalVM
	@Environment(\.modelContext) private var modelContext
	@EnvironmentObject var navController: NavController
	@State var moodEntry: MoodEntry
	
	
	@State private var showSeed: Bool = true
	@State private var showFlower: Bool = false
	
	var activeFlower: Flower {
		selectedFlower ?? randomFlower
	}
	@State private var randomFlower: Flower
	
	// DEBUG
	@State private var selectedFlower: Flower? = nil
	
	init(moodEntry: MoodEntry) {
		self._moodEntry = State(initialValue: moodEntry)
		let type = moodEntry.mood.moodOption.associatedFlowers.randomElement() ?? .tulip
		let flower = Flower(ftype: type)
		self._randomFlower = State(initialValue: flower)
	}
	            
	
	var body: some View {
		ZStack {
			globalVM.currentTheme.color(for: .mainBG).ignoresSafeArea()
			Color.blue.opacity(0.2).ignoresSafeArea()
			VStack {
				
				Spacer()
					.frame(height: 40)
				
				Text("You have received a seed for your \(moodEntry.mood.moodOption) mood.")
					.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.smallTitleFontSize))
					.multilineTextAlignment(.center)
				
				Spacer()
				
				ZStack {
					Image(.customSeed)
						.font(.system(size: 160))
						.foregroundStyle(.weatheredBark)
						.scaleEffect(!showSeed ? 0 : 1)
						.animation(.bouncy(duration: 0.3), value: showSeed)
						.onTapGesture {
							showSeed = false
							showFlower = true
						}
					
					
					Image(.customFlower)
						.font(.system(size: 160))
						.foregroundStyle(activeFlower.ftype.displayColor)
						.scaleEffect(showFlower ? 1 : 0)
						.animation(.bouncy(duration: 0.4)
							.delay(0.7),
								   value: showFlower)
				}
				
				Group {
					let vowels: [Character] = ["a", "e", "i", "o", "u"]
					let lcFlowerName = activeFlower.ftype.rawValue.lowercased()
					
					let article = vowels.contains(lcFlowerName.first ?? " ") ? "an" : "a"
					
					Text("You have received \(article) \(activeFlower.ftype.rawValue)!")
						.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.smallTitleFontSize))
						.multilineTextAlignment(.center)
						.opacity(showFlower ? 1 : 0)
						.animation(.linear.delay(1.3), value: showFlower)
				}
				
				Button(action: {
					moodEntry.flower = activeFlower
					modelContext.insert(moodEntry)
					try? modelContext.save()
					
					navController.navigate(to: .garden)
				}) {
					Text("Accept this feeling")
				}
				.mainButtonStyle(
					gradientColor1: .whisper,
					fontColor: .black,
					strokeColor: .mistyRose,
					font: globalVM.currentTheme.bodyFont
				)
				.opacity(showFlower ? 1 : 0)
				.animation(.linear
					.delay(2.5),
						   value: showFlower)
				
				Spacer()
			}
			.padding()
		}
		.navigationBarBackButtonHidden()
	}
}

#Preview {
	NavigationStack {
		SeedGetView(
			moodEntry: MoodEntry(
				dateCreated: .now,
				mood: .allMoods.randomElement()!,
				journal: "EH"
			)
		)
		.environment(GlobalVM())
		.environmentObject(NavController())
	}
}
