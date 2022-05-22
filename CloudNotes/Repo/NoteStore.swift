//
//  NoteStore.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


protocol NoteStore: NoteLoader, NoteAdder, NoteDeleter {}


class FirebaseNoteStore: NoteStore {
    
    private var databaseRef: Firestore
    
    init() {
        databaseRef = Firestore.firestore()
    }
    
    func loadNotes() async throws -> [Note] {
        try await databaseRef
            .collection("notes")
            .getCodable()
    }
    
    func loadNote(from id: String) async throws -> Note {
        try await databaseRef
            .collection("notes")
            .whereField("id", isEqualTo: id)
            .getCodable().first!
    }
    
    func add(note: Note) async throws {
        try await databaseRef
            .collection("notes")
            .document()
            .setData(note.toDict())
    }
    
    func delete(note id: String) async throws -> Note? {
        try await databaseRef
            .collection("notes")
            .whereField("id", isEqualTo: id)
            .deleteFirstDocument()
    }
}
