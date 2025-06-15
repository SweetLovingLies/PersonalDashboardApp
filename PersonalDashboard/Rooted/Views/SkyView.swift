//
//  SkyView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/12/25.
//

import SwiftUI
import Combine

struct SkyView: View {
	@State var timer: AnyCancellable?
	@State private var clouds: [Cloud] = []
	let cloudSize: CGFloat
	
	let viewWidth: CGFloat
	let viewHeight: CGFloat
	
	var body: some View {
		ZStack {
			ForEach(clouds) { cloud in
				CloudView(cloud: cloud, skyWidth: viewWidth, skyHeight: viewHeight, cloudSize: cloudSize)
			}
		}
		.frame(width: viewWidth, height: viewHeight)
		.clipped() // Hides overflow
		.onAppear {
			startCloudAnimation()
		}
	}
	
	private func startCloudAnimation() {
		/// Make clouds at random intervals (timer)
		timer = Timer.publish(every: 5, on: .main, in: .common)
			.autoconnect()
			.sink { _ in
				// Maybe I'll make a cloud. You never know.
				if Double.random(in: 0...1) < 0.7 { // 70% chance
					createClouds()
//					print(clouds.count)
				}
			}
	}
	
	private func createClouds() {
		/// Randomize the clouds' Y position
		/// Make them slide across the screen
		/// And then have them disappear when they're off the screen
		
		// Between -400 and 500 on the screen
		let randomY = CGFloat.random(in: -400...500)
		// May change this to be slower later
		let randomSpeed = Double.random(in: 20...40)
		
		// Create a cloud and append it to the clouds array
		let newCloud = Cloud(yOffset: randomY, speed: randomSpeed)
		clouds.append(newCloud)
		
		// Remove after the duration is over to prevent memory leaks
		DispatchQueue.main.asyncAfter(deadline: .now() + randomSpeed) {
			clouds.removeAll { $0.id == newCloud.id }
		}
		
	}
}

//#Preview {
//	SkyView(cloudSize: 150)
//}

struct Cloud: Identifiable {
	let id = UUID()
	var yOffset: CGFloat
	var speed: Double
}

// Helper View
struct CloudView: View {
	let cloud: Cloud
	let skyWidth: CGFloat
	let skyHeight: CGFloat
	let cloudSize: CGFloat
	
	@State private var xOffset: CGFloat = -700
	
	var clampedYOffset: CGFloat {
		min(max(cloud.yOffset, 0), skyHeight - cloudSize)
	}
	
	var body: some View {
		Image(systemName: "cloud.fill")
			.font(.system(size: cloudSize))
			.foregroundStyle(.white)
			.offset(x: xOffset, y: clampedYOffset)
			.onAppear {
				withAnimation(.linear(duration: cloud.speed)) {
					xOffset = skyWidth + 500
				}
			}
	}
}


