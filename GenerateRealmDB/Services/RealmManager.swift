//
//  RealmManager.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 20.11.2026.
//

import Foundation
import Realm
import RealmSwift

protocol BookStorageProtocol {
    func generateData(completion: @escaping () -> () )
}

final class RealmManager: BookStorageProtocol{
    
    private let generator: DataGeneratorProtocol
    
    init(generator: DataGeneratorProtocol) {
        self.generator = generator
    }
    
    func generateData(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInitiated).async{
            let currentTime = Date()
            
            let generatedAuthors = self.generator.generateAuthors()
            
            let realm = try! Realm()
            try! realm.write {
                for author in generatedAuthors {
                    let authorObject = AuthorObject()
                    authorObject.fullName = author.fullName
                    
                    for book in author.books {
                        let bookObject = BookObject()
                        bookObject.title = book.title
                        bookObject.year = book.year
                        
                        authorObject.books.append(bookObject)
                    }
                    
                    realm.add(authorObject)
                }
            }
            
            print("Generate and save in \(Date().timeIntervalSince(currentTime)) sec")
            
            DispatchQueue.main.async {
                completion()
            }
            
        }
    }
    
    
}
