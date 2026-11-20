//
//  BooksViewController.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 19.11.2026.
//

import UIKit

final class BooksViewController: BaseVC {
    
    private let storage: BookStorageProtocol = RealmManager(generator: MockDataGenerator())

    private let booksView = BooksView()
    private var items: [BookItem] = []

    override func loadView() {
        view = booksView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Books"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Generate", style: .plain, target: self, action: #selector(generateTapped))
        
        booksView.delegate = self
    }

    @objc private func generateTapped() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        booksView.setLoading(true)
        
        storage.generateData { [weak self] in
            guard let self else { return }
            
            self.loadBooks()
        }
        
        
    }
    
    private func loadBooks(){
        storage.fetchBooks { [weak self] items in
            guard let self else {return}
            
            self.items = items
            self.booksView.setLoading(false)
            self.booksView.configure(items: items)
            self.navigationItem.rightBarButtonItem?.isHidden = true
        }
    }
}

extension BooksViewController: BooksViewDelegate {

    func booksView(_ view: BooksView, didSelectBookAt index: Int) {
        let item = items[index]
        let detailVC = BookDetailViewController(book: item.book, author: item.author)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
