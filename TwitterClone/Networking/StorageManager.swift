//
//  StorageManager.swift
//  TwitterClone
//
//  Created by Jim Yang on 2023-11-20.
//

import Foundation
import Combine
import FirebaseStorage
import FirebaseStorageCombineSwift

enum FirestorageError: Error{
    case invalidImageID
}

final class StorageManager{
    static let shared = StorageManager()
    
    let storage = Storage.storage()
    
    func getDownloadURL(for id: String?) -> AnyPublisher<URL, Error>{
        guard let id = id else{
            return Fail(error: FirestorageError.invalidImageID)
                .eraseToAnyPublisher()
        }
        
        return storage.reference(withPath: id)
            .downloadURL()
            .print()
            .eraseToAnyPublisher()
    }
    
    func uploadProfilePhoto(with randomID: String, image: Data, metaData: StorageMetadata) -> AnyPublisher<StorageMetadata, Error>{
        storage
            .reference()
            .child("images/\(randomID).jpg")
            .putData(image, metadata: metaData)
            .print()
            .eraseToAnyPublisher()
    }
}
