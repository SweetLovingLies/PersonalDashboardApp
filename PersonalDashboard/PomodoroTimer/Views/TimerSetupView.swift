//
//  TimerSetupView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/18/25.
//

import SwiftUI

struct TimerSetupView: View {
	@State var selectedHours: Int
	@State var selectedMinutes: Int
	@State var selectedSeconds: Int
	@State var selectedCatagory: FocusCategory = .selectOne

	let onOptionsSelected: (Int, Int, Int, FocusCategory) -> Void
	
	private let hoursRange = 0...23
	private let minutesRange = 0...59
	private let secondsRange = 0...59
	
	@Environment(GlobalVM.self) var globalVM
	
	@Binding var isEditingMode: Bool
	
	var body: some View {
		ZStack {
			globalVM.currentTheme.color(for: .mainBG).opacity(0.8).ignoresSafeArea()
				.shadow(color: globalVM.currentTheme.color(for: .accent1), radius: 10)
			VStack {
				Menu {
					Picker("", selection: $selectedCatagory) {
						ForEach(FocusCategory.allCases, id: \.self) { category in
							Text(category.rawValue)
								.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.midTitleFontSize))
						}
					}
				} label: {
					HStack {
						Text(selectedCatagory.rawValue)
						Image(systemName: "chevron.up.chevron.down")
					}
					.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.bodyFontSize))
				}
				.tint(globalVM.currentTheme.color(for: .textPrimary))
				.colorScheme(globalVM.currentTheme.colorScheme == .dark ? .dark : .light)
		
				HStack(spacing: 0) {
					TimePickerColumn(title: "hr", range: hoursRange, selection: $selectedHours)
					TimePickerColumn(title: "min", range: minutesRange, selection: $selectedMinutes)
					TimePickerColumn(title: "sec", range: secondsRange, selection: $selectedSeconds)
				}

				Button {
					onOptionsSelected(selectedHours, selectedMinutes, selectedSeconds, selectedCatagory)
					isEditingMode = false
				} label: {
					Text("Select")
						.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.midTitleFontSize))
						.bold()
						.padding()
						.frame(width: 150, height: 50)
						.background(globalVM.currentTheme.color(for: .accent1))
						.foregroundStyle(.black)
						.cornerRadius(10)
				}
			}
		}
	}
}

private struct TimePickerColumn: View {
	@Environment(GlobalVM.self) var globalVM
	
	let title: String
	let range: ClosedRange<Int>
	@Binding var selection: Int
	
	var body: some View {
		Picker(title, selection: $selection) {
			ForEach(range, id: \.self) { value in
				Text("\(value) \(title)")
			}
		}
		.pickerStyle(.wheel)
		.colorScheme(globalVM.currentTheme.colorScheme == .dark ? .dark : .light )
		.frame(width: 100, height: 100)
	}
}
