//
//  GardenView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/12/25.
//

import SwiftUI
import SwiftData

struct GardenView: View {
	@Query private var moodEntry: [MoodEntry]
	
	var flowers: [Flower] = [
		Flower(ftype: .fireLily),
		Flower(ftype: .sunflower),
		Flower(ftype: .cherryBlossom),
	]
	
	//	var flowers: [Flower] {
	//		moodEntry.compactMap { $0.flower }
	//	}
	
	
	var body: some View {
		ZStack(alignment: .top) {
			Color.blue.opacity(0.4).ignoresSafeArea()
			
			SkyView(
				cloudSize: 120,
				viewWidth: UIScreen.main.bounds.width,
				viewHeight: 400
			)
			
			Image(systemName: "sun.max.fill")
				.foregroundStyle(.starshine)
				.font(.system(size: 110))
				.offset(x: 130)

			
			HStack(spacing: 0) {
				ForEach(flowers.indices, id: \.self) { _ in
					ZStack {
						Image("hillBG")
							.resizable()
							.scaledToFill()
							.scrollTransition(axis: .horizontal) { content, phase in
								content
									.offset(x: phase.value * -160)
							}
					}
					.containerRelativeFrame(.horizontal)
				}
			}
			.ignoresSafeArea()
			
			
			VStack(spacing: 0) {
				Spacer()
				
				ZStack(alignment: .bottom) {
					ScrollView(.horizontal, showsIndicators: false) {
						HStack(spacing: 0) {
							ForEach(flowers) { flower in
								VStack(spacing: 6) {
									Text(flower.ftype.rawValue)
										.font(.caption)
										.frame(width: 100, height: 30)
										.background(.thinMaterial)
										.clipShape(.rect(cornerRadius: 5))
									
									Image(.customFlower)
										.font(.system(size: 170))
										.foregroundStyle(Color.pastel())
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
					}
					.scrollTargetBehavior(.paging)
				}
				
				Rectangle()
					.ignoresSafeArea()
					.foregroundStyle(.leafyGreen)
					.frame(height: 140)
			}
			
		}
	}
}

#Preview {
	GardenView()
}

