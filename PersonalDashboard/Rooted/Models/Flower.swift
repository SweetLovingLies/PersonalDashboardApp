//
//  Flower.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 6/12/25.
//

import Foundation


struct Flower: Identifiable, Codable {
	var id: UUID = UUID()
	let ftype: FlowerType
	var growthStage: GrowthStage = .seed
	var hasBeenWatered: Bool = false
	var isPlanted: Bool = false
	var datePlanted: Date? = nil
	
	func getDatePlanted() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM dd, yyyy"
		
		return datePlanted.map { dateFormatter.string(from: $0) } ?? "Unknown"
	}

}

