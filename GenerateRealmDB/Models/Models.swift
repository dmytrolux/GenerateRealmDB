//
//  Models.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 19.11.2026.
//

import Foundation

typealias BookItem = (book: Book, author: Author)

struct Book {
    let title: String
    let year: Int
}

struct Author {
    let fullName: String
    let books: [Book]
}
