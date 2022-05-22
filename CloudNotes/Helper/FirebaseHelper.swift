//
//  FirebaseHelper.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

extension CollectionReference {
    
    func getCodables<T: Decodable>() async throws -> [T] {
        try await withCheckedThrowingContinuation { continuation in
            getDocuments { query, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    var dataArray: [T] = []
                    for document in (query!.documents) {
                        do {
                            let data = try document.data(as: T.self)
                            dataArray.append(data)
                        } catch let error {
                            continuation.resume(throwing: error)
                        }
                    }
                    continuation.resume(returning: dataArray)
                }
            }
        }
    }
    
}


extension Query {
    
    func getCodable<T: Decodable>() async throws -> [T] {
        try await withCheckedThrowingContinuation({ continuation in
            getDocuments { query, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    var dataArray: [T] = []
                    for document in (query!.documents) {
                        do {
                            let data = try document.data(as: T.self)
                            dataArray.append(data)
                        } catch let error {
                            continuation.resume(throwing: error)
                            return
                        }
                    }
                    continuation.resume(returning: dataArray)
                }
            }
        })
    }
    
    func deleteFirstDocument<T: Decodable>() async throws -> T? {
        try await withCheckedThrowingContinuation({ continuation in
            getDocuments { query, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    let document = query!.documents.first!
                    document.reference.delete { error in
                        let data = try? document.data(as: T.self)
                        continuation.resume(returning: data)
                    }
                }
            }
        })
    }
    
}
