//
//  AddNoteViewModel.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import Foundation

protocol AddNoteDelegate: AnyObject {
    func noteAdded()
}

class AddNoteViewModel: ObservableObject {
    
    @Published var noteAddingState: NoteAddingState = .none
    private var noteAdder: NoteAdder
    private weak var delegate: AddNoteDelegate?
    
    enum NoteAddingState {
        case none
        case loading
        case error(String)
        case addedNote(Note)
    }
    
    init(noteAdder: NoteAdder, delegate: AddNoteDelegate) {
        self.noteAdder = noteAdder
        self.delegate = delegate
    }
    
    func add(title: String, description: String) {
        self.noteAddingState = .loading
        if validate(title: title, description: description) {
            let note = createNote(title: title, description: description)
            addNoteToRemote(note: note)
        }
    }
    
    private func validate(title: String, description: String) -> Bool {
        if title.isEmpty {
            self.noteAddingState = .error("Title can't be empty")
            return false
        }
        if description.isEmpty {
            self.noteAddingState = .error("description can't be empty")
            return false
        }
        return true
    }
    
    private func createNote(title: String, description: String) -> Note {
        .init(id: UUID().uuidString, title: title, description: description)
    }
    
    private func addNoteToRemote(note: Note) {
        Task {
            do {
                try await noteAdder.add(note: note)
                DispatchQueue.main.async {
                    self.noteAddingState = .addedNote(note)
                    self.delegate?.noteAdded()
                }
            } catch let error {
                DispatchQueue.main.async {
                    self.noteAddingState = .error(error.localizedDescription)
                }
            }
        }
    }
    
}
