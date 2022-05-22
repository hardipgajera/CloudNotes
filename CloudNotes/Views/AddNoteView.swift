//
//  AddNoteView.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import SwiftUI

struct AddNoteView: View {
    
    @StateObject var viewModel : AddNoteViewModel
    
    @Binding var openAddNote: Bool
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                titleView
                
                descriptionView
                Spacer()
                saveView
            }.padding()
            
            
            switch viewModel.noteAddingState {
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .alert(
            isPresented: Binding(get: {
                switch viewModel.noteAddingState {
                case .addedNote(_), .error(_):
                    return true
                default:
                    return false
                }
            }, set: { _ in
                self.viewModel.noteAddingState = .none
            })) {
                switch viewModel.noteAddingState {
                case .error(let error):
                    return Alert(
                        title: Text("Error"),
                        message: Text(error),
                        dismissButton: .cancel()
                    )
                case .addedNote(let note):
                    return Alert(
                        title: Text("Success"),
                        message: Text("Successfully added \(note.title ?? "")"),
                        dismissButton: .default(Text("Okay"),action: {
                            self.openAddNote = false
                        })
                    )
                default:
                    fatalError()
                }
            }
    }
    
    var titleView: some View {
        TextField("Title", text: $title)
            .font(.system(size: 25))
            .foregroundColor(.gray)
    }
    
    var descriptionView: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $description)
                .foregroundColor(.black)
            if description.isEmpty {
                Text("description")
                    .foregroundColor(Color(uiColor: .placeholderText))
                    .padding(.top, 10)
                    .padding(.leading,4)
                    .allowsHitTesting(false)
            }
        }
    }
    
    var saveView: some View {
        HStack {
            Button {
                viewModel.add(title: title, description: description)
            } label: {
                Text("Save")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(4)
                    .padding(.horizontal)
                    .background(Color.blue)
                    .cornerRadius(6)
            }
        }
        .frame(height: 60)
    }
    
}
