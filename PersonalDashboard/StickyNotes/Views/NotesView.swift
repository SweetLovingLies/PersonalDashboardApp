//
//  NotesView.swift
//  PersonalDashboard
//
//  Created by Morgan Harris on 5/30/25.
//
// MARK: This view will display all created notes for selection and editing

import SwiftUI
import SwiftData

struct NotesView: View {
	@Environment(GlobalVM.self) private var globalVM
	
	@State private var showSheet: Bool = false
	//	@State private var editNote: Note? = nil
	//	@State private var noteToDelete = Note? = nil
	@State private var showDeletionConfirmation: Bool = false
	
	@State private var availableColors: [Color] = []
	
	private let columns: [GridItem] = [
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
	@State private var isGridMode: Bool = true
	@State private var showToolbar: Bool = false
	
	// NOTES
	@Query var notes: [Note]
	var filter: String = ""
	var filteredNotes: [Note] {
		let filtered = notes.filter { note in
			filter.isEmpty ||
			note.title.lowercased().contains(filter.lowercased()) ||
			note.content.lowercased().contains(filter.lowercased()) ||
			note.category.rawValue.lowercased().contains(filter.lowercased())
		}
		
		return filtered.sorted { a, b in
			if a.isPinned && b.isPinned {
				return true
			}
			
			if !a.isPinned && !b.isPinned {
				return false
			}
			
			return a.lastModifiedAt > b.lastModifiedAt
		}
		
		
	}
	
	var body: some View {
		NavigationStack {
			ZStack {
				globalVM.currentTheme.color(for: .mainBG).ignoresSafeArea()
				
				VStack(spacing: 0) {
					ZStack {
						globalVM.currentTheme.color(for: .headerBG)
							.ignoresSafeArea()
						
						Text("Sticky Notes")
							.font(.custom(globalVM.currentTheme.headerFont, size: GlobalVM.headerFontSize))
							.foregroundStyle(globalVM.currentTheme.color(for: .textHeader))
					}
					.frame(height: GlobalVM.headerHeight)
					
					// MARK: Toolbar
					if showToolbar {
						ZStack(alignment: .trailing) {
							globalVM.currentTheme.color(for: .accent1)
							
							HStack {
								Button(action:{showSheet.toggle()}) {
									Text("Add")
								}
								.buttonStyle(.borderedProminent)
								.foregroundStyle(globalVM.currentTheme.color(for: .textSecondary))
								.tint(globalVM.currentTheme.color(for: .accent3))
								.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.buttonFontSize))
								
								EditButton()
									.buttonStyle(.borderedProminent)
									.padding(.trailing, 10)
									.foregroundStyle(globalVM.currentTheme.color(for: .textSecondary))
									.tint(globalVM.currentTheme.color(for: .accent3))
									.font(.custom(globalVM.currentTheme.bodyFont, size: GlobalVM.buttonFontSize))
							}
						}
						.frame(height: 50)
						.transition(.move(edge: .top))
						.zIndex(-1) // Forces the bar behind the header
					}
					
					// MARK: Toolbar Button
					HStack {
						Button(action: {
							withAnimation {
								showToolbar.toggle()
							}
						}) {
							ZStack {
								ZStack(alignment: .bottom) {
									if showToolbar {
										globalVM.currentTheme.color(for: .accent1)
									} else {
										globalVM.currentTheme.color(for: .headerBG)
									}
									
									Triangle()
										.frame(height: 15)
										.foregroundStyle(globalVM.currentTheme.color(for: .mainBG))
								}
								
								Image(systemName: showToolbar ? "chevron.up" : "chevron.down")
									.foregroundStyle(globalVM.currentTheme.color(for: .textSecondary))
									.offset (y: -5)
							}
							.frame(width: 30, height: 40)
							.offset(y: -1)
							.animation(nil, value: showToolbar)
						}
						.buttonStyle(RawButtonStyle())
						
						Spacer()
					}
					.padding(.horizontal, 10)
					.padding(.bottom)
					
					
					ScrollView {
						LazyVGrid(columns: columns, spacing: 5) {
							
							#if DEBUG
							ForEach(Note.samplesNotes) { note in
								StickyNoteView(note: note)
							}
							
							#else
							ForEach(filteredNotes) { note in
								StickyNoteView(note: note)
							}
							#endif
							
						}
						.padding(.horizontal)
					}
					.scrollContentBackground(.hidden)
					
					
					Spacer()
					
				}
				.sheet(isPresented: $showSheet) {
					AddEditNoteView()
						.environment(globalVM)
				}
			}
		}
	}
}

#Preview {
	NotesView()
		.environment(GlobalVM())
}
