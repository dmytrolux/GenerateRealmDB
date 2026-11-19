//
//  MockLib.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 19.11.2026.
//

import Foundation

enum MockLib {
    
    static let authors: [Author] = [
        Author(fullName: "Шевченко Дмитро Олегович", books: [
            Book(title: "Велика карта жахів", year: 1975),
            Book(title: "Таємна криниця містики", year: 1965),
            Book(title: "Моторошна долина драконів", year: 1994),
            Book(title: "Кришталева річка світів", year: 1947),
            Book(title: "Зіркова пісня кохання", year: 1981),
            Book(title: "Дитяча скарбниця сюрпризів", year: 1970),
            Book(title: "Самотня стежка бажань", year: 1966),
            Book(title: "Безкрайня руїна подій", year: 1988),
            Book(title: "Майбутня легенда горизонтів", year: 1981),
            Book(title: "Туманна могила розваг", year: 1989),
        ]),
        Author(fullName: "Мельник Олег Сергійович", books: [
            Book(title: "Туманна стежка жахів", year: 1979),
        ]),
        Author(fullName: "Коваленко Андрій Євгенович", books: [
            Book(title: "Зіркова карта драконів", year: 1968),
        ]),
    ]
    
    static var books: [Book] {
        return authors.flatMap{$0.books}
    }

    static var bookPairs: [(book: Book, author: Author)] {
        return authors.flatMap { author in
            author.books.map { book in (book: book, author: author) }
        }
    }
    
}
