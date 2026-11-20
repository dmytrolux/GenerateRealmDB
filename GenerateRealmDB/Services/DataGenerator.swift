//
//  DataGenerator.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 20.11.2026.
//

import Foundation

protocol DataGeneratorProtocol {
    func generateAuthors() -> [Author]
}

final class MockDataGenerator: DataGeneratorProtocol {
    let countBooksInAuthor = 100
    
    func generateAuthors() -> [Author] {
        var authors: [Author] = []
        
        for firstName in MockData.firstName {
            for midleName in MockData.midleName {
                for secondName in MockData.secondName {
                    let fullName = "\(firstName) \(midleName) \(secondName)"
                    authors.append(Author(fullName: fullName, books: makeBooks()))
                }
            }
        }
        return authors
    }
    
    private func makeBooks() -> [Book] {
        var books: [Book] = []
        
        for _ in 1...countBooksInAuthor{
            let book = Book(title: makeBookTitle(), year: Int.random(in: 1991...2026))
            books.append(book)
        }
        return books
    }
    
    private func makeBookTitle() -> String {
        let word0 = MockData.bookNameWord0.randomElement() ?? ""
        let word1 = MockData.bookNameWord1.randomElement() ?? ""
        let word2 = MockData.bookNameWord2.randomElement() ?? ""
        return "\(word0) \(word1) \(word2)"
    }
    
    
    
    
}
