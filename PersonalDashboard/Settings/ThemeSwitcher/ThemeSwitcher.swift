//
//  ThemeSwitcher.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/20/25.
//

import SwiftUI


struct ThemeSwitcher: View {
	@Environment(GlobalVM.self) private var globalVM
	private let themes: [Theme] = Theme.all
	
	private let columns: [GridItem] = [
		GridItem(.flexible()),
		GridItem(.flexible()),
	]
	
	@State private var r = Double.random(in: 0...1)
	
	@State private var float = false
	
	var body: some View {
		
		ZStack {
			if globalVM.currentTheme.tsBG != "" {
				if r > 0.95 && globalVM.currentTheme == .apothecaryGirl {
					Image(.jinshinMaoMaoBG)
						.resizable()
						.ignoresSafeArea()
						.animation(.default, value: globalVM.currentTheme.tsBG)
				} else {
					Image(globalVM.currentTheme.tsBG)
						.resizable()
						.ignoresSafeArea()
						.animation(.default, value: globalVM.currentTheme.tsBG)
				}
			} else {
				globalVM.currentTheme.color(for: .mainBG)
					.ignoresSafeArea()
			}
			
			ZStack {
				Rectangle()
					.foregroundStyle(.ultraThinMaterial.opacity(0.8))
					.clipShape(.rect(cornerRadius: 40))
					.overlay(RoundedRectangle(cornerRadius: 40).stroke(globalVM.currentTheme.color(for: .accent1), lineWidth: 4))
					.padding(.horizontal, 10)
				
				ScrollView {
					LazyVGrid(columns: columns) {
						ForEach(themes) { theme in
							IconView(
								theme: theme,
								isSelected: globalVM.currentTheme == theme,
								onSelect: { globalVM.currentTheme = theme }
							)
						}
					}
				}
			}
			.offset(y: float ? -4 : 4)
			.onAppear {float = true}
			.animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: float)
			.frame(height: 600)
		}
		//		.onAppear {
		//			print(r)
		//		}
	}
}


struct IconView: View {
	let theme: Theme
	let isSelected: Bool
	let onSelect: () -> Void
	
	var body: some View {
		ZStack {
			if theme.tsIcon.contains("custom") {
				ZStack {
					theme.color(for: .accent2).opacity(0.6)
						.clipShape(RoundedRectangle(cornerRadius: 15))
						.overlay(RoundedRectangle(cornerRadius: 15)
							.stroke(.white, lineWidth: isSelected ? 6 : 4))
					Image(theme.tsIcon)
						.padding(5)
						.font(.system(size: isSelected ? 100 : 70))
						.foregroundStyle(theme.color(for: .accent1))
						.onTapGesture {
							onSelect()
						}
				}
				.frame(width: 100, height: 100)
				
			} else {
				ZStack {
					theme.color(for: .accent2).opacity(0.6)
						.aspectRatio(1, contentMode: .fill)
						.clipShape(RoundedRectangle(cornerRadius: 15))
						.overlay(RoundedRectangle(cornerRadius: 15)
							.stroke(.white, lineWidth: isSelected ? 6 : 4))
					
					
					Image(systemName: theme.tsIcon)
						.padding(5)
						.font(.system(size: isSelected ? 100 : 70))
						.foregroundStyle(theme.color(for: .accent1))
					
						.onTapGesture {
							onSelect()
						}
				}
				.frame(width: 100, height: 100)
				
				
			}
		}
		.padding()
	}
}


#Preview {
	ThemeSwitcher()
		.environment(GlobalVM())
}
