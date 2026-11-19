//
//  Models.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 19.11.2026.
//

import Foundation

struct Book {
    let title: String
    let year: Int
}

struct Author {
    let fullName: String
    let books: [Book]
}
