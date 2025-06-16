//
//  LandingView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/22/25.
//

import SwiftUI
import SwiftData

struct LandingView: View {
	@State private var vm = ViewModel()
	@Environment(GlobalVM.self) private var globalVM
	@State private var currentAffirmation: String = ""
	@State private var float = false
	@EnvironmentObject var navController: NavController
	
	@Query private var allMoodEntries: [MoodEntry]
	
	
	var body: some View {
		
		ZStack {
			globalVM.currentTheme.color(for: .mainBG).ignoresSafeArea()
			VStack {
				
				ZStack {
					globalVM.currentTheme.color(for: .headerBG)
						.ignoresSafeArea()
					
					Text("Dashboard")
						.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.headerFontSize))
						.foregroundStyle(globalVM.currentTheme.color(for: .textHeader))
				}
				.frame(height: GlobalVM.headerHeight)
				.padding(.bottom)
				
				// MARK: Affirmation!
				ZStack {
					Image(.cloudHeart)
						.resizable()
						.scaledToFit()
						.frame(height: 230)
					
					
						.offset(y: float ? -4 : 4)
						.shadowOutlineStyle(
							color: globalVM.currentTheme.color(for: .accent1),
							range: 3
						)
					
					Text(currentAffirmation)
						.foregroundStyle(globalVM.currentTheme.colorScheme == .dark ? globalVM.currentTheme.color(for: .textSecondary) : globalVM.currentTheme.color(for: .textPrimary))
					
					
					
						.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.midTitleFontSize))
						.offset(y: float ? -4 : 4)
						.frame(width: 220)
						.multilineTextAlignment(.center)
				}
				.animation(.linear(duration: 1.5).repeatForever(autoreverses: true), value: float)
				.frame(width: 300)
				
				Spacer()
					.frame(height: 30)
				
				// MARK: How are you feeling?
				ZStack {
					Color.blue.opacity(0.2)
					
					VStack {
						// Header
						GeometryReader { geo in
							ZStack {
								SkyView(cloudSize: 35, viewWidth: geo.size.width, viewHeight: 100)
								HStack(alignment: .bottom) {
									Text("How are you feeling?")
										.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.smallTitleFontSize))
										.bold()
										.padding(.top, 20)
										.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
								}
							}
						}
						
						// Picker
						ZStack {
							VStack(spacing: 0) {
								RoundedRectangle(cornerRadius: 5)
									.frame(height: 32)
									.foregroundStyle(.blue)
									.opacity(0.06)
							}
							
							Picker("Pick your Mood", selection: $vm.selectedMood) {
								ForEach(vm.moods, id: \.self) { mood in
									Text(mood.moodOption.rawValue)
										.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.bodyFontSize))
										.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
								}
							}
							.labelsHidden()
						}
						.pickerStyle(.wheel)
						.frame(height: 50)
						
						Spacer()
						
						// Randomized Pastel Flowers
						VStack(spacing: 0) {
							let range = 1...7
							HStack {
								ForEach(range, id: \.self) { _ in
									Image(.customFlower)
										.foregroundStyle(Color.pastel())
										.font(.system(size: 32))
										.shadowOutlineStyle(color: .white, range: 0.5)
								}
							}
							
							// Grass and Buttons
							ZStack {
								Rectangle()
									.foregroundStyle(.leafyGreen)
									.frame(height: 75)
								
								HStack {
									if !vm.didLogMoodToday(entries: allMoodEntries) {
										Button(action: {
											navController.navigate(to: .reflection(selectedMood: vm.selectedMood))
										}) {
											Text("Select!")
										}
										.mainButtonStyle(
											gradientColor1: globalVM.currentTheme.color(for: .accent2),
											fontColor: globalVM.currentTheme.color(for: .textPrimary),
											strokeColor: globalVM.currentTheme.color(for: .accent1),
											font: globalVM.currentTheme.bodyFont
										)
									}
									
									Button(action:{navController.navigate(to: .garden)}) {
										Text("Visit Garden")
									}
									.mainButtonStyle(
										gradientColor1: globalVM.currentTheme.color(for: .accent2),
										fontColor: globalVM.currentTheme.color(for: .textPrimary),
										strokeColor: globalVM.currentTheme.color(for: .accent1),
										font: globalVM.currentTheme.bodyFont
									)
								}
								
							}
						}
					}
				}
				.clipShape(RoundedRectangle(cornerRadius: 20))
				.overlay(RoundedRectangle(cornerRadius: 20)
					.stroke(globalVM.currentTheme.color(for: .accent1), lineWidth: 5))
				.frame(height: 250)
				.padding(.horizontal, 30)
				
				Spacer()
				
				
			}
		}
		.onAppear {
			if currentAffirmation.isEmpty {
				currentAffirmation = vm.getAffirmationForToday()
			}
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
				float = true
			}
			
			UNUserNotificationCenter.current().getNotificationSettings { settings in
				if settings.authorizationStatus == .authorized {
					vm.make530pmNotification()
				} else {
					print("Notification not authorized yet.")
				}
			}
			
			//			let fontFamilyNames = UIFont.familyNames
			//			for familyName in fontFamilyNames {
			//
			//				print("Font Family Name = [\(familyName)]")
			//				let names = UIFont.fontNames(forFamilyName: familyName)
			//				print("Font Names = [\(names)]")
			//			}
		}
	}
}

#Preview {
	LandingView()
		.environment(GlobalVM())
		.environmentObject(NavController())
}
