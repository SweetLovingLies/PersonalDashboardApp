//
//  HangerView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/15/25.
//

import SwiftUI

struct FlowerView: View {
	let flower: Flower
	
	var body: some View {
		VStack(spacing: 0) {
			ZStack(alignment: .top) {
				Triangle()
					.foregroundStyle(.clear)
					.overlay(
						Triangle()
							.stroke(.weatheredBark, lineWidth: 2)
					)
					.frame(width: 60, height: 30)
				
				Image(systemName: "heart.fill")
					.font(.system(size: 15))
					.foregroundStyle(flower.ftype.displayColor)
					.offset(y: -5)
			}
			
			VStack {
				Text(flower.ftype.rawValue)
					.minimumScaleFactor(0.4)
					.lineLimit(1)
					.font(.custom("Fredoka-Medium", size: GlobalVM.headlineFontSize))
					.bold()
				
				Text(flower.growthStage.ageState())
				
				Text("Date Planted:")
					.bold()
				Text(flower.getDatePlanted())
				
			}
			.font(.custom("Fredoka-Medium", size: GlobalVM.captionFontSize))
			.foregroundStyle(.black)
			.frame(width: 110)
			.padding(5)

			.multilineTextAlignment(.center)
			
			.background(.whisper)
			.clipShape(.rect(cornerRadius: 5))
			.overlay(
				RoundedRectangle(cornerRadius: 5)
					.stroke(.weatheredBark, lineWidth: 2))
			.padding(.bottom, 5)
		}
	}
}
