//
//  AppDependency.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import Foundation


class AppDependency {
    
    static let shared = AppDependency()
    
    private init() {}
    
    var noteStore: NoteStore {
        return FirebaseNoteStore()
    }
}
