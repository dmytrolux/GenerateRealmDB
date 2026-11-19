//
//  BookDetailViewController.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 19.11.2026.
//

import UIKit

final class BookDetailViewController: BaseVC {

    private let book: Book
    private let author: Author
    private let detailView = BookDetailView()

    init(book: Book, author: Author) {
        self.book = book
        self.author = author
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Book"
        navigationItem.largeTitleDisplayMode = .never

        detailView.delegate = self
        detailView.configure(book: book, author: author)
    }
}

extension BookDetailViewController: BookDetailViewDelegate {
    
    func bookDetailViewDidTapAuthor(_ view: BookDetailView) {
        print("BookDetailViewController: bookDetailViewDidTapAuthor")
        let viewControllers = navigationController?.viewControllers ?? []

        if viewControllers.count >= 2, viewControllers[viewControllers.count - 2] is AuthorViewController {
            navigationController?.popViewController(animated: true)
            return
        }

        let authorVC = AuthorViewController(author: author)
        navigationController?.pushViewController(authorVC, animated: true)
    }
}

