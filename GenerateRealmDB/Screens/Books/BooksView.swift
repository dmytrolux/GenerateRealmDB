//
//  BooksView.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 19.11.2026.
//

import UIKit

protocol BooksViewDelegate: AnyObject {
    func booksView(_ view: BooksView, didSelectBookAt index: Int)
}

final class BooksView: UIView {

    weak var delegate: BooksViewDelegate?

    private var items: [(book: Book, author: Author)] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.reuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Empty.\nTap Generate."
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        setupLayout()
        updateEmptyLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(items: [(book: Book, author: Author)]) {
        self.items = items
        tableView.reloadData()
        updateEmptyLabel()
    }

    func setLoading(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
            emptyLabel.isHidden = true
            tableView.isHidden = true
        } else {
            activityIndicator.stopAnimating()
            updateEmptyLabel()
        }
    }

    private func setupLayout() {
        addSubview(tableView)
        addSubview(emptyLabel)
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),

            emptyLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func updateEmptyLabel() {
        emptyLabel.isHidden = !items.isEmpty
        tableView.isHidden = items.isEmpty
    }

    private func booksCountText(_ count: Int) -> String {
        return count == 1 ? "1 book" : "\(count) books"
    }
}

extension BooksView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return booksCountText(items.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.reuseId, for: indexPath) as! BookCell
        let item = items[indexPath.row]
        cell.configure(book: item.book, author: item.author)
        return cell
    }
}

extension BooksView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.booksView(self, didSelectBookAt: indexPath.row)
    }
}

