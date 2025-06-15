//
//  AddEditNoteView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/30/25.
//
// MARK: This view will display the UI for adding notes

import SwiftUI
import SwiftData

struct AddEditNoteView: View {
	@Environment(GlobalVM.self) private var globalVM
	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	
	
	var note: Note? = nil
	@State private var availableColors: [Color] = []
	
	@State private var newNoteTitle: String = ""
	@State private var newNoteContent: String = ""
	@State private var selectedColor: Color = .yellow
	@State private var isNNPined: Bool = false
	@State private var newCatagory: Note.Category = .general
	
	
	var body: some View {
		ZStack {
			globalVM.currentTheme.color(for: .mainBG)
				.ignoresSafeArea()
			
			VStack {
				Text(note == nil ? "Add New Note" : "Edit Note")
					.font(.largeTitle)
					.bold()
					.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
				
				Form {
					Section("Note Title") {
						TextField("Enter a title!", text: $newNoteTitle)
							.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
							.tint(globalVM.currentTheme.color(for: .accent1))
					}
					Section("Something small I need to remember is...") {
						TextEditor(text: $newNoteContent)
							.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
							.tint(globalVM.currentTheme.color(for: .accent1))
							.frame(height: 100)
					}
					
					Section("Select Catagory") {
						Picker("Select Catagory", selection: $newCatagory) {
							ForEach(Note.Category.allCases, id: \.self) { catagory in
								Text(catagory.rawValue.capitalized)
									.foregroundStyle(globalVM.currentTheme.color(for: .textPrimary))
							}
						}
						.pickerStyle(.segmented)
						
					}
					
					Section("Select Color") {
						HStack(alignment: .center) {
							ForEach(availableColors, id: \.self) { color in
								Button(action: {
									selectedColor = color
								}) {
									Circle()
										.foregroundStyle(color)
										.overlay(
											Circle()
												.stroke(.gray, lineWidth: color == selectedColor ? 4 : 1)
										)
								}
								.frame(width: 50, height: 50)
								.buttonStyle(.plain)
							}
						}
						.padding()
						
					}
					
					Section("Pin Me?") {
						Toggle("Pin Me?", isOn: $isNNPined)
					}
					
					HStack(alignment: .center) {
						Spacer()
						Button(action: {
							let newNote = Note(title: newNoteTitle, content: newNoteContent, isPinned: isNNPined, category: newCatagory, color: selectedColor.toHex()!, createdAt: .now, lastModifiedAt: .now)
							
							modelContext.insert(newNote)
							
							try? modelContext.save()
							
							dismiss()
							
						}) {
							Text("Save")
						}
						.mainButtonStyle(
							gradientColor1: globalVM.currentTheme.color(for: .accent1),
							gradientColor2: globalVM.currentTheme.color(for: .accent2),
							fontColor: globalVM.currentTheme.color(for: .textPrimary),
							strokeColor: globalVM.currentTheme.color(for: .accent3),
							font: globalVM.currentTheme.bodyFont
						)
						Spacer()

					}
					.listRowBackground(Color.clear)
					

					
				}
				.scrollContentBackground(.hidden)
				
				
			}
			.padding()
		}
		.onAppear {
			availableColors = [
				globalVM.currentTheme.color(for: .accent1), globalVM.currentTheme.color(for: .accent2), globalVM.currentTheme.color(for: .accent3), globalVM.currentTheme.color(for: .headerBG)
			]
		}
		
		
		
		
    }
}

#Preview {
	AddEditNoteView()
		.environment(GlobalVM())
}
