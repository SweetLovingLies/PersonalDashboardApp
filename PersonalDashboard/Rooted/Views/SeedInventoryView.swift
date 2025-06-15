//
//  SeedInventoryView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/15/25.
//

import SwiftUI
import SwiftData

struct SeedInventoryView: View {
	@EnvironmentObject var navController: NavController
	
	@State var allMoodEntries: [MoodEntry]
	
	var unplantedSeeds: [MoodEntry] {
		allMoodEntries.filter {
			if let flower = $0.flower {
				return !flower.isPlanted
			}
			return false
		}
	}
	
	@State private var clickedSeed: MoodEntry? = nil
	
	var body: some View {
		VStack(spacing: 3) {
			ZStack {
				Color.pickedPlum.opacity(0.3).ignoresSafeArea()
					.clipShape(.rect(cornerRadius: 20))
				
				ScrollView(.horizontal) {
					HStack(spacing: 30) {
						ForEach(unplantedSeeds) { seed in
							Image(.customSeed)
								.font(.system(size: 50))
								.foregroundStyle(.weatheredBark)
								.onTapGesture {
									clickedSeed = seed
								}
						}
					}
				}
				.padding()
			}
			.frame(height: 80)
			
			if let seed = clickedSeed {
				VStack(spacing: 10) {
					Button(action:{
						navController.navigate(to: .wateringTransition(seed: seed))
					}) {
						Text("Plant this Feeling?")
					}
					.font(.custom("Fredoka-Medium", size: GlobalVM.bodyFontSize))
					.foregroundStyle(.black)
					
					Button(action:{
						clickedSeed = nil
					}) {
						Text("Cancel")
					}
					.font(.custom("Fredoka-Medium", size: GlobalVM.bodyFontSize))
					.foregroundStyle(.black)
				}
				.padding(5)
				.frame(width: 200)
				.background(seed.flower!.ftype.displayColor.opacity(0.4))
				
				.clipShape(RoundedCorner(radius: 10, corners: [.bottomLeft, .bottomRight]))
			}
		}
		.padding(.horizontal)
	}
}

//#Preview {
//	let container = try! ModelContainer(
//		for: MoodEntry.self,
//		configurations: ModelConfiguration(isStoredInMemoryOnly: true)
//	)
//	
//	let flowers: [FlowerType] = [.sunflower, .jasmine, .dandelion]
//	for type in flowers {
//		let entry = MoodEntry(
//			dateCreated: .now,
//			mood: .content,
//			journal: "Preview Entry"
//		)
//		entry.flower = Flower(ftype: type, growthStage: .seed, hasBeenWatered: false, datePlanted: nil)
//		container.mainContext.insert(entry)
//	}
//
//	return SeedInventoryView()
//		.modelContainer(container)
//}
