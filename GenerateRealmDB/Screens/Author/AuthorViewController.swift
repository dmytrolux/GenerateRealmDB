//
//  AuthorViewController.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 20.11.2026.
//

import UIKit

final class AuthorViewController: UIViewController {

    private let author: Author
    private let authorView = AuthorView()
    
    weak var delegate: AuthorViewDelegate?

    init(author: Author) {
        self.author = author
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = authorView
        authorView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Author"
        navigationItem.largeTitleDisplayMode = .never

        authorView.configure(author: author)
    }
}

extension AuthorViewController: AuthorViewDelegate {
    func authorView(_ view: AuthorView, didSelectBookAt index: Int) {
        let book = author.books[index]
        let detailVC = BookDetailViewController(book: book, author: author)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

