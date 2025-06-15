//
//  StickyNoteView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/30/25.
//
// MARK: This will be what displays when the NotesView is in grid mode!

import SwiftUI

struct StickyNoteView: View {
	var note: Note
	@Environment(GlobalVM.self) private var globalVM
	
//	var onDelete: () -> Void
//	var onEdit: () -> Void
//	var onPin: () -> Void
	
    var body: some View {
		ZStack {
			note.uiColor
			
			VStack(alignment: .leading) {
				Text(note.title)
					.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.smallTitleFontSize))
					.underline()
				
				Text("Catagory: \(note.category.rawValue.capitalizingFirstLetter())")
					.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.headlineFontSize))
				
				Text(note.content)
					.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.bodyFontSize))
					.lineLimit(2)
				
				
				Group {
					Text("Date Created: \(note.createdAt.formatted())")
						.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.captionFontSize))
					
					Rectangle()
						.frame(height: 1)
					
					Text("Last Modified: \(note.lastModifiedAt.formatted())")
						.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.captionFontSize))
				}
				.font(.caption)
				.fontWeight(.light)
				.opacity(0.6)
			}
			.padding()
			.foregroundStyle(.black)
		}
		.frame(maxWidth: 200, maxHeight: 200)
		
		
		
		
    }
}

#Preview {
	StickyNoteView(note: Note.sampleNote)
	StickyNoteView(note: Note.longSampleNote)
}
