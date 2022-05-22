//
//  NoteListView.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import SwiftUI

struct NoteListView: View {
    
    @StateObject var viewModel : NoteListViewModel
    @State private var openAddNote: Bool = false
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.noteArray) { note in
                    NoteView(note: note)
                }
                .onDelete(perform: deleteNotes(at:))
            }
            .toolbar {
                Button {
                    openAddNote = true
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.black)
                }
                
            }
            .task { await viewModel.loadNote() }
            
            if viewModel.isLoading {
                ProgressView()
            }
            
        }
        .navigationBarTitle(Text("Notes"))
        .sheet(isPresented: $openAddNote, onDismiss: nil) {
            AddNoteView(
                viewModel: AddNoteViewModel(
                    noteAdder: AppDependency.shared.noteStore,
                    delegate: viewModel
                ),
                openAddNote: $openAddNote
            )
        }
    }
    
    func deleteNotes(at offsets: IndexSet) {
        offsets.forEach { index in
            Task {
                let note = viewModel.noteArray[index]
                await viewModel.delete(note: note)
            }
        }
    }
    
}
