//
//  NoteAdder.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import Foundation

protocol NoteAdder {
    func add(note: Note) async throws
}
