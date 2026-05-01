//
//  PomodoroView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftUI
import AVFoundation

struct PomodoroView: View {
	@Environment(GlobalVM.self) var globalVM
	@Environment(StatsVM.self) var statsVM
		
	@State private var vm = ViewModel()
	
	var body: some View {
		ZStack {
			ZStack {
				globalVM.currentTheme.color(for: .mainBG).ignoresSafeArea()
				
				VStack(alignment: .center, spacing: 30) {
					ZStack {
						globalVM.currentTheme.color(for: .headerBG).ignoresSafeArea()
					
						
						Text("Focus Mode: \(vm.isRunning ? "On" : "Off")")
							.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.headerFontSize))
								.foregroundStyle(globalVM.currentTheme.color(for: .textHeader))
					}
					.frame(height: GlobalVM.headerHeight)
					
					VStack {
						if vm.sessionCategory != .selectOne {
							Text(vm.sessionCategory.focusLine)
								.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.buttonFontSize))
								.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
							
								.multilineTextAlignment(.center)
								.fixedSize(horizontal: false, vertical: true)
							
								.padding(.bottom)
								.padding(.horizontal, 30)
						} else {
							Text("Make sure to pick a catagory!")
								.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.smallTitleFontSize))
								.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
							
								.multilineTextAlignment(.center)
								.fixedSize(horizontal: false, vertical: true)
							
								.padding(.bottom)
								.padding(.horizontal, 30)
						}

						ZStack {
							ZStack {
								globalVM.currentTheme.color(for: .accent2)
								Image(.lofiKittyCat)
									.resizable()
							}
							.clipShape(Circle())
							
							
							ZStack {
								Circle() // Background Bar
									.stroke(globalVM.currentTheme.color(for: .accent1), lineWidth: 20)
								
								Circle() // Progress Bar
									.trim(from: 0, to: vm.timeRemaining / vm.totalTime)
									.stroke(.white, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
									.rotationEffect(.degrees(-90))
									.animation(.easeInOut, value: vm.timeRemaining)
							}
						}
						.frame(width: 300, height: 300)
					}
					
					// MARK: Selected Time
					
					ZStack {
						globalVM.currentTheme.color(for: .headerBG)
						Text(vm.formattedTime())
							.font(.system(size: 60, weight: .light))
							.foregroundStyle(globalVM.currentTheme.color(for: .textHeader))
							.onTapGesture {
								vm.isEditingMode = true
							}
					}
					.frame(height: 100)
					
					HStack(spacing: 20) {
						Button {
							if vm.isRunning {
								vm.pauseTimer()
							} else {
								vm.startTimer()
							}
						} label: {
							Text(vm.isRunning ? "PAUSE" : "START")
								
						}
						.buttonStyle(PomodoroStateButtonStyle(globalVM: globalVM, color: globalVM.currentTheme.color(for: .accent1), isEnabled: vm.isTimeSet && vm.sessionCategory != .selectOne))
						.disabled(
							!(
								vm.isTimeSet &&
								vm.timeRemaining > 0 &&
								vm.sessionCategory != .selectOne
							)
						)

						Button {
							vm.resetTimer()
						} label: {
							Text("RESET")
								
						}
						.buttonStyle(PomodoroStateButtonStyle(globalVM: globalVM, color: globalVM.currentTheme.color(for: .accent2), isEnabled: vm.isTimeSet && vm.isRunning))
						.disabled(!vm.isTimeSet || !vm.isRunning)
					}
					.padding(.top)
					
					Spacer()
				}
			}
			
			VStack(alignment: .center) {
				TimerSetupView(selectedHours: Int(vm.timeRemaining / 3600),
				selectedMinutes: Int(vm.timeRemaining.truncatingRemainder(dividingBy: 3600) / 60),
				selectedSeconds: Int(vm.timeRemaining.truncatingRemainder(dividingBy: 60)),
							   onOptionsSelected: { hours, minutes, seconds, catagory  in
					vm.updateTime(hours: hours, minutes: minutes, seconds: seconds)
					vm.sessionCategory = catagory
				}, isEditingMode: $vm.isEditingMode)
				.frame(width: 350, height: 210)
				.clipShape(RoundedRectangle(cornerRadius: GlobalVM.cornerRadiusLarge))
				
				Image(systemName: "heart.fill")
					.foregroundStyle(globalVM.currentTheme.color(for: .accent3))
					.font(.system(size: 45))
					.offset(y: -5)
					.padding(-25)
					.animation(
						.bouncy
						.delay(0.015),
						value: vm.isEditingMode
					)
			}
			.offset(y: vm.isEditingMode ? -70 : 600)
			.animation(.bouncy, value: vm.isEditingMode)
		}
		.onAppear {
			vm.onSessionCompleted = { duration, catagory in
				statsVM.logPomodoro(duration: duration, category: catagory)
			}
		}
	}
}

extension PomodoroView {
	@Observable
	class ViewModel {
		var isEditingMode: Bool = false // Change as needed
		var timeRemaining: TimeInterval = 0
		var totalTime: TimeInterval = 0
		var isRunning: Bool = false
		var isTimeSet: Bool = false
		var sessionCategory: FocusCategory = .selectOne
		
		private let musicOptions = ["JapanVillageFlute", "LeaveMeAlone", "LookingUp", "OnAVacation", "PowderSnow","SpringIsHere"]
		private var timer: Timer?

		// Callback for when a session is completed
		var onSessionCompleted: ((TimeInterval, FocusCategory) -> Void)?

		func formattedTime() -> String {
			if !isTimeSet {
				return "--:--:--"
			} else {
				let h = Int(timeRemaining / 3600)
				let m = Int(timeRemaining.truncatingRemainder(dividingBy: 3600) / 60)
				let s = Int(timeRemaining.truncatingRemainder(dividingBy: 60))
				return String(format: "%02d:%02d:%02d", h, m, s)
			}
		}
		
		func updateTime(hours: Int, minutes: Int, seconds: Int) {
			totalTime = TimeInterval(hours * 3600 + minutes * 60 + seconds)
			timeRemaining = totalTime
			isTimeSet = totalTime > 0
		}
		
		func startTimer() {
			guard !isRunning, timeRemaining > 0 else { return }
			isRunning = true
			timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
				self?.tick()
			}
			
			let randomMusicFileName = musicOptions.randomElement()!
			startBackgroundSound(musicFileName: randomMusicFileName)
		}
		
		func pauseTimer() {
			isRunning = false
			timer?.invalidate()
			timer = nil
			
			stopBackgroundSound()
		}
		
		func resetTimer() {
			pauseTimer()
			timeRemaining = totalTime
			
			stopBackgroundSound()
		}
		
		private func tick() {
			if timeRemaining > 0 {
				timeRemaining -= 1
			} else {
				pauseTimer()
				onSessionCompleted?(totalTime, sessionCategory)
			}
		}
	}

}

//#Preview {
//	PomodoroView()
//		.environment(GlobalVM())
//}
