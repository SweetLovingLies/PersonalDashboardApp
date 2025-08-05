//
//  SeedGetView.swift
//  PersonalDashboard
//
//  Created by Hana Harris on 6/11/25.
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
	
	
	@State private var rotate: Bool = false
	
	var body: some View {
		ZStack {
			globalVM.currentTheme.color(for: .mainBG).ignoresSafeArea()
			Color.blue.opacity(0.2).ignoresSafeArea()
			
			VStack {
				
				Spacer()
				
				(
					Text("Your ")
					+
					Text(moodEntry.mood.moodOption.rawValue).bold()
					+
					Text(" mood has left something behind for you...")
				)
					.font(.custom("Fredoka-Medium", size: GlobalVM.smallTitleFontSize))
					.multilineTextAlignment(.center)
				
				ZStack {
					Image(.forBadge)
						.resizable()
						.frame(width: 250, height: 250)
						.foregroundStyle(activeFlower.ftype.displayColor.opacity(0.4))
					
					// MARK: Rotation
						.rotationEffect(.degrees(rotate ? 360 : 0), anchor: .center)
						.animation(
							.linear(duration: 4.5)
							.repeatForever(autoreverses: false),
							value: rotate
						)
					
					// MARK: SCALE
						.scaleEffect(showFlower ? 1 : 0)
						.animation(.bouncy(duration: 1)
							.delay(0.9),
								   value: showFlower)
					
					Image(.forBadge)
						.resizable()
						.frame(width: 300, height: 300)
						.foregroundStyle(activeFlower.ftype.displayColor.opacity(0.2))
					
					// MARK: Rotation
						.rotationEffect(.degrees(rotate ? -360 : 0), anchor: .center)
						.animation(
							.linear(duration: 5.5)
							.repeatForever(autoreverses: false),
							value: rotate
						)
					
					// MARK: SCALE
						.scaleEffect(showFlower ? 1 : 0)
						.animation(.bouncy(duration: 1)
							.delay(1.1),
								   value: showFlower)
					   
					Image(.customSeed)
						.font(.system(size: 160))
						.foregroundStyle(.weatheredBark)
						.scaleEffect(!showSeed ? 0 : 1)
						.animation(.bouncy(duration: 0.3), value: showSeed)
						.onTapGesture {
							showSeed = false
							showFlower = true
							
							rotate.toggle()
						}
					
					Image(activeFlower.imagePath)
						.font(.system(size: 160))
						.foregroundStyle(activeFlower.ftype.displayColor)
						.scaleEffect(showFlower ? 1 : 0)
						.animation(.bouncy(duration: 0.4)
							.delay(0.7),
								   value: showFlower)
						.zIndex(1)
						.shadowOutlineStyle(
							color: activeFlower.ftype.displayColor == .white ? .black : .white, range: 1)
				}
				
				Group {
					let vowels: [Character] = ["a", "e", "i", "o", "u"]
					let lcFlowerName = activeFlower.ftype.rawValue.lowercased()
					
					let article = vowels.contains(lcFlowerName.first ?? " ") ? "an" : "a"
					
					Text("You have received \(article) \(activeFlower.ftype.rawValue) seed!")
						.font(.custom("Fredoka-Medium", size: GlobalVM.smallTitleFontSize))
						.multilineTextAlignment(.center)
						.opacity(showFlower ? 1 : 0)
						.animation(.linear
							.delay(1.7),
								   value: showFlower)
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
					font:  "Fredoka-Medium"
				)
				.opacity(showFlower ? 1 : 0)
				.animation(.linear
					.delay(3.3),
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
//				mood: .burntOut,
				journal: "EH"
			)
		)
		.environment(GlobalVM())
		.environmentObject(NavController())
	}
}
