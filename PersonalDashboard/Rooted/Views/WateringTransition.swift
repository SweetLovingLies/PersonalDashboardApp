//
//  WateringTransition.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/15/25.
//
// MARK: Needed
/// Rainbow Asset (DONE)
/// Watering Animation ?????
/// MAYBE A RAIN ANIMATION? (Maybe)

import SwiftUI
import SwiftData

struct WateringTransition: View {
	@Environment(\.modelContext) private var modelContext
	@EnvironmentObject var navController: NavController
	@State var seed: MoodEntry
	
	
	
    var body: some View {
		ZStack(alignment: .top) {
			Color.blue.opacity(0.4).ignoresSafeArea()
			
			Image(.customSun)
				.foregroundStyle(.starshine)
				.font(.system(size: 110))
				.offset(x: 130)
			
			Image(.rainbowLonger)
				.resizable()
				.scaleEffect(x: -1)
				.offset(x: -210)
				.opacity(0.6)
				.blur(radius: 2)
	
			VStack {
				RainCloudView()
					.offset(y: 30)
				
				Spacer()
				
				Rectangle()
					.ignoresSafeArea()
					.foregroundStyle(.leafyGreen)
					.frame(height: 140)
			}
		}
		.navigationBarBackButtonHidden()
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				seed.flower!.isPlanted = true
				seed.flower!.datePlanted = .now
				
				try? modelContext.save()
				
				navController.navigate(to: .garden)
			}
		}
    }
}

#Preview {
	WateringTransition(seed: MoodEntry(dateCreated: .now, mood: .calm, journal: "None"))
		.environmentObject(NavController())
}



struct Drop: Identifiable {
	let id = UUID()
	let x: CGFloat
	let duration: Double
}


struct RainCloudView: View {
	private let cloudWidth: CGFloat = 250
	private let dropCount = 15
	private let minDuration: Double = 1.0
	private let maxDuration: Double = 2.2
	
	private var drops: [Drop] = (0..<15).map { _ in
		Drop(
			x: CGFloat.random(in: -120...120),          // tweak spread
			duration: Double.random(in: 1.0...2.2)    // varied speed
		)
	}

	var body: some View {
		VStack {
			Image(systemName: "cloud.fill")
				.resizable()
				.frame(width: cloudWidth, height: cloudWidth * 0.65)
				.foregroundStyle(.gray)
			
			TimelineView(.animation) { timeline in
				Canvas { ctx, size in
					let now = timeline.date.timeIntervalSinceReferenceDate
					
					for drop in drops {
						let progress = (now.truncatingRemainder(dividingBy: drop.duration)) / drop.duration
						let y = progress * size.height
						
						// Use your symbol (defined below)
						if let droplet = ctx.resolveSymbol(id: drop.id) {
							ctx.draw(droplet, at: CGPoint(x: size.width / 2 + drop.x, y: y))
						}
					}
				} symbols: {
					ForEach(drops) { drop in
						Image(.customDroplet)
							.foregroundStyle(.blue)
							.id(drop.id)
					}
				}
			}
		}
	}
}
