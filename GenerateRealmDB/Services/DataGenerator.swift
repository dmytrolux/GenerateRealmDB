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
    func generateAuthors() -> [Author] {
        var authors: [Author] = []
        
        for firstName in MockData.firstName {
            for midleName in MockData.midleName {
                for secondName in MockData.secondName {
                    let fullName = "\(firstName) \(midleName) \(secondName)"
                    authors.append(Author(fullName: fullName, books: []))
                }
            }
        }
        return authors
    }
    
    
    
    
}
