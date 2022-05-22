//
//  NoteDeleter.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import Foundation

protocol NoteDeleter {
    func delete(note id: String) async throws -> Note?
}
