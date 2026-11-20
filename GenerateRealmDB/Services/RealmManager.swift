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
    func fetchBooks(competion: @escaping ([BookItem]) -> () )
    func isEmpty() -> Bool
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
                
                realm.deleteAll()
                
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
    
    func fetchBooks(competion: @escaping ([BookItem]) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async{
            let currentTime = Date()
            
            let realm = try! Realm()
            let bookObjects = realm.objects(BookObject.self)
            var authorCache: [ObjectId: Author] = [:]
            var items: [BookItem] = []
            
            for bookObject in bookObjects {
                guard let authorObject = bookObject.authors.first else {continue}
                
                let author: Author
                if let cachedAuthor = authorCache[authorObject.id] {
                    author = cachedAuthor
                } else {
                    let books = authorObject.books.map { Book(title: $0.title, year: $0.year) }
                    author = Author(fullName: authorObject.fullName, books: Array(books))
                    authorCache[authorObject.id] = author
                }
                
                let book = Book(title: bookObject.title, year: bookObject.year)
                items.append(BookItem(book: book, author: author))
                
            }
            
            items.shuffle()
            
            print("Fetched books in \(Date().timeIntervalSince(currentTime)) sec")
            
            DispatchQueue.main.async {
                competion(items)
            }
        }
    }
    
    func isEmpty() -> Bool {
        let realm = try! Realm()
        return realm.objects(BookObject.self).isEmpty
    }
    
}
