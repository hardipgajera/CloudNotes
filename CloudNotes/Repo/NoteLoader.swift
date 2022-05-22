//
//  NoteLoader.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import Foundation

protocol NoteLoader {
    func loadNotes() async throws -> [Note]
    func loadNote(from id: String) async throws -> Note
}
