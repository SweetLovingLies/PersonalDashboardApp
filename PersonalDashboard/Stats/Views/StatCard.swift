//
//  StatCard.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/21/25.
//

import SwiftUI

struct StatCard: View {
	@Environment(GlobalVM.self) private var globalVM

	let title: String
	let value: String
	let icon: String
	
	var body: some View {
		ZStack {
			Rectangle()
				.foregroundStyle(globalVM.currentTheme.color(for: .accent2))
				.cornerRadius(15)
			
			HStack {
				Image(systemName: icon)
					.font(.system(size: 30))
					.foregroundStyle(globalVM.currentTheme.color(for: .accent1))
					.padding()
					.padding(.trailing, -10)
					.shadowOutlineStyle(
						color: globalVM.currentTheme.colorScheme == .dark ? .white : .midnightSlate,
						range: 0.6
					)
				
				HStack(spacing: 0) {
					Rectangle()
						.frame(width: 2)
						.foregroundStyle(globalVM.currentTheme.colorScheme == .dark ? .white : .midnightSlate)
					
					Rectangle()
						.frame(width: 3)
						.foregroundStyle(globalVM.currentTheme.color(for: .accent1))
					
					Rectangle()
						.frame(width: 2)
						.foregroundStyle(globalVM.currentTheme.colorScheme == .dark ? .white : .midnightSlate)
				}
				
				VStack(alignment: .leading) {
					Text(title)
						.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
						.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.sectionFontSize))
						.underline()
						
					Text(value)
						.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
						.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.bodyFontSize))
						
				}
				.padding(.leading, 10)
				Spacer()
			}
		}
	}
}
