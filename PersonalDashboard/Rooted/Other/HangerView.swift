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
					.bold()
				
				Text(flower.growthStage.ageState())
					.font(.caption)
				
				Text("Date Planted:")
					.font(.caption)
					.bold()
				Text(flower.getDatePlanted())
					.font(.caption)
				
			}
			.frame(width: 100)

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
