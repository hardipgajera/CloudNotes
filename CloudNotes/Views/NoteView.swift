//
//  NoteView.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import SwiftUI

struct NoteView: View {
    let note: Note
    var body: some View {
        VStack(alignment: .center) {
            Text(note.title.asEmptyOrString)
            Text(note.description.asEmptyOrString)
                .multilineTextAlignment(.leading)
                .lineLimit(0)
        }.padding()
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: .dummy())
    }
}
