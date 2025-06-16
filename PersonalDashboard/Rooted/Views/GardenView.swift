//
//  GardenView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/12/25.
//

import SwiftUI
import SwiftData

struct GardenView: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(GlobalVM.self) private var globalVM
	@EnvironmentObject var navController: NavController
	@Query private var allMoodEntries: [MoodEntry]
	var flowers: [Flower] {
		allMoodEntries
			.compactMap { $0.flower }
			.filter { $0.datePlanted != nil }
	}
	
	@State private var showInventory: Bool = false
	
	private let columns: [GridItem] = [
		GridItem(.flexible())
	]
	
	@State private var vm: ViewModel = ViewModel()
	
	
	var body: some View {
		ZStack(alignment: .top) {
			
			switch vm.timeOfDay {
			case "day":
				Color.blue.opacity(0.4).ignoresSafeArea()
			case "night":
				Color.urbanSky.ignoresSafeArea()
			default:
				Color.sunDown.ignoresSafeArea()
			}
			
			if vm.timeOfDay == "day" {
				SkyView(
					cloudSize: 120,
					viewWidth: UIScreen.main.bounds.width,
					viewHeight: 400
				)
			}
			
			switch vm.timeOfDay {
			case "night":
				Image(systemName: "moon.fill")
					.foregroundStyle(.amberLight)
					.font(.system(size: 110))
					.offset(x: -110)
					.onTapGesture {
						withAnimation(.bouncy()) {
							showInventory.toggle()
						}
					}
				
			case "day":
				Image(.customSun)
					.foregroundStyle(.starshine)
					.font(.system(size: 110))
					.offset(x: 130)
					.onTapGesture {
						withAnimation(.bouncy()) {
							showInventory.toggle()
						}
					}
				
			default:
				Image(.customSun)
					.foregroundStyle(.fallHourLeaf)
					.font(.system(size: 110))
					.offset(x: -110)
					.onTapGesture {
						withAnimation(.bouncy()) {
							showInventory.toggle()
						}
					}
			}
			
			
			//			HStack(spacing: 0) {
			//				ForEach(flowers.indices, id: \.self) { _ in
			//					ZStack {
			//						Image("hillBG")
			//							.resizable()
			//							.scaledToFill()
			//							.scrollTransition(axis: .horizontal) { content, phase in
			//								content
			//									.offset(x: phase.value * -160)
			//							}
			//					}
			//					.containerRelativeFrame(.horizontal)
			//				}
			//			}
			//			.ignoresSafeArea()
			
			
			VStack(spacing: 0) {
				Spacer()
				
				ZStack(alignment: .bottom) {
					ScrollView(.horizontal, showsIndicators: false) {
						LazyHGrid(rows: columns) {
							ForEach(flowers) { flower in
								VStack(spacing: 6) {
									FlowerView(flower: flower)
									
									switch flower.growthStage {
									case .seed:
										EmptyView()
									case .sprout:
										Image(.customSprout)
											.font(.system(size: 100))
											.foregroundStyle(.leafyGreen)
									case .flowering:
										Image(.customFlower)
											.font(.system(size: 100))
											.foregroundStyle(flower.ftype.displayColor)
									case .mature:
										Image(.customFlower)
											.font(.system(size: 170))
											.foregroundStyle(flower.ftype.displayColor)
									}
								}
								.frame(width: 240)
								.containerRelativeFrame(.horizontal)
								.scrollTransition(axis: .horizontal) { content, phase in
									content
										.scaleEffect(phase.isIdentity ? 1 : 0.95)
										.opacity(phase.isIdentity ? 1 : 0.7)
										.offset(x: phase.value * 30)
								}
							}
						}
						.frame(height: 120)
					}
					.scrollClipDisabled()
					.scrollTargetBehavior(.paging)
				}
				
				// Grass
				ZStack {
					var grassColor: Color {
						switch vm.timeOfDay {
						case "day":
							return .leafyGreen
						case "night":
							return .ebonyLeaf
							default:
							return .fallHourLeaf
						}
					}
					
					
					Rectangle()
						.ignoresSafeArea()
						.foregroundStyle(grassColor)
					
					Button(action: {navController.navigateToRoot()}) {
						Text("Exit")
					}
					.mainButtonStyle(
						gradientColor1: .whisper,
						fontColor: .black,
						strokeColor: .mistyRose,
						font: globalVM.currentTheme.bodyFont
					)
				}
				.frame(height: 140)
			}
			
			if showInventory {
				SeedInventoryView(allMoodEntries: allMoodEntries)
					.environmentObject(navController)
					.offset(y: 140)
			}
		}
		.navigationBarBackButtonHidden()
		.onAppear {
			if vm.modelContext == nil {
				vm.modelContext = modelContext
			}
		}
		
	}
}

extension GardenView {
	@Observable
	final class ViewModel {
		
		var modelContext: ModelContext?
		
		init(modelContext: ModelContext? = nil) {
			self.modelContext = modelContext
		}
		
		func updateGrowth(for moodEntry: MoodEntry) {
			guard let flower = moodEntry.flower,
				  let plantedDate = flower.datePlanted else { return }
			
			let calendar = Calendar.current
			let startOfPlantedDay = calendar.startOfDay(for: plantedDate)
			let startOfToday = calendar.startOfDay(for: Date())
			
			let daysPassed = calendar.dateComponents([.day], from: startOfPlantedDay, to: startOfToday).day ?? 0
			let newStage = flower.growthStage.nextStage(daysSincePlanting: daysPassed)
			
			if newStage != flower.growthStage {
				moodEntry.flower!.growthStage = newStage
				try? modelContext!.save()
			}
		}
				
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
	}
	
}

#Preview {
	NavigationStack {
		let container = try! ModelContainer(
			for: MoodEntry.self,
			configurations: ModelConfiguration(isStoredInMemoryOnly: true)
		)
		
		let flowers: [FlowerType] = [.sunflower, .iris, .cosmos]
		for type in flowers {
			var flower = Flower(ftype: type)
			flower.isPlanted = true
			flower.datePlanted = Calendar.current.date(byAdding: .day, value: -2, to: .now)
			
			let entry = MoodEntry(
				dateCreated: .now,
				mood: .content,
				journal: "Preview Entry"
			)
			entry.flower = flower
			container.mainContext.insert(entry)
		}
		
		return GardenView()
			.modelContainer(container)
			.environment(\.modelContext, container.mainContext)
			.environmentObject(NavController())
			.environment(GlobalVM())
		
		
		
	}
}

