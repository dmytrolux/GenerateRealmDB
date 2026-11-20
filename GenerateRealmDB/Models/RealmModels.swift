//
//  RealmModels.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 20.11.2026.
//

import Foundation
import RealmSwift
import Realm

class BookObject: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var year: Int = 0
    @Persisted(originProperty: "books") var authors: LinkingObjects<AuthorObject>
}

class AuthorObject: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var fullName: String = ""
    @Persisted var books: List<BookObject>
}
