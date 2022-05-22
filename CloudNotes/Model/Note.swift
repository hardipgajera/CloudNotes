//
//  Note.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: String?
    let title: String?
    let description: String?
}


extension Note {
    func toDict() -> [String: Any] {
        return [
            "id": id.asEmptyOrString,
            "title": title.asEmptyOrString,
            "description": description.asEmptyOrString
        ]
    }
    
    static func dummy() -> Note {
        .init(
            id: UUID().uuidString,
            title: "What is note?",
            description: "some words that you write down quickly to help you remember something"
        )
    }
}
