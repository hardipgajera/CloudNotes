//
//  NoteListViewModel.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import Foundation

class NoteListViewModel: ObservableObject {
    
    @Published var noteArray: [Note] = []
    @Published var error: Error?
    @Published var isLoading: Bool = false
    
    private var noteLoader: NoteLoader
    private var noteDeleter: NoteDeleter
    
    init(noteLoader: NoteLoader, noteDeleter: NoteDeleter) {
        self.noteLoader = noteLoader
        self.noteDeleter = noteDeleter
    }
    
    @MainActor
    func loadNote() async {
        self.isLoading = true
        do {
            noteArray = try await noteLoader.loadNotes()
            self.isLoading = false
        } catch let e {
            self.error = e
            self.isLoading = false
        }
    }
    
    @MainActor
    func delete(note: Note) async {
        self.isLoading = true
        do {
            _ = try await noteDeleter.delete(note: note.id!)
            self.isLoading = false
            await loadNote()
        } catch let e {
            self.error = e
            self.isLoading = false
        }
    }
}

extension NoteListViewModel: AddNoteDelegate {
    func noteAdded() {
        Task {
            await loadNote()
        }
    }
}
