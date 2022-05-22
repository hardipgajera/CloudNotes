//
//  CloudNotesApp.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import SwiftUI
import FirebaseCore

@main
struct CloudNotesApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                NoteListView(viewModel:
                                NoteListViewModel(
                                    noteLoader: AppDependency.shared.noteStore,
                                    noteDeleter: AppDependency.shared.noteStore
                                )
                )
            }
        }
    }
}
