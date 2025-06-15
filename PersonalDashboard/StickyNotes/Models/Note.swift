//
//  Note.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/30/25.
//

import SwiftData
import SwiftUI

@Model
final class Note: Identifiable, Equatable {
	var id: UUID
	
	var title: String
	var content: String
	var isPinned: Bool
	var category: Category
	var color: String // Must make conversion functions later
	
	var createdAt: Date
	var lastModifiedAt: Date
	
	init(id: UUID = UUID(), title: String, content: String, isPinned: Bool = false, category: Category, color: String, createdAt: Date, lastModifiedAt: Date) {
		self.id = id
		self.title = title
		self.content = content
		self.isPinned = isPinned
		self.category = category
		self.color = color
		self.createdAt = createdAt
		self.lastModifiedAt = lastModifiedAt
	}
	
	enum Category: String, CaseIterable, Codable {
		case general
		case work
		case personal
		case health
	}
}

extension Note {
	var uiColor: Color {
		Color.fromHex(color)
	}
	
	func setColor(from color: Color) {
		if let hex = color.toHex() {
			self.color = hex
		}
	}
}


extension Note {
	static let sampleNote = Note(
		title: "Test Note",
		content: "This is a test note!",
		category: .general,
		color: "#FF6B6B",
		createdAt: .now,
		lastModifiedAt: .now
	)

	static let longSampleNote = Note(
		title: "Long Test Note",
		content: "This is a test note with a lot of text in it in order to test text truncating!",
		category: .general,
		color: "#FAD1D1",
		createdAt: .now,
		lastModifiedAt: .now
	)
	
	static let samplesNotes: [Note] = [sampleNote, longSampleNote]
}
