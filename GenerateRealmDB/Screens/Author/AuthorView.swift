//
//  Untitled.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 20.11.2026.
//

import UIKit

protocol AuthorViewDelegate: AnyObject {
    func authorView(_ view: AuthorView, didSelectBookAt index: Int)
}

final class AuthorView: UIView {

    private enum TableSection: Int, CaseIterable {
        case info
        case books
    }

    private var author: Author?
    private let infoCellId = "AuthorInfoCell"
    
    weak var delegate: AuthorViewDelegate?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: infoCellId)
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.reuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(author: Author) {
        self.author = author
        tableView.reloadData()
    }

    private func setupLayout() {
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func booksCountText(_ count: Int) -> String {
        return count == 1 ? "1 book" : "\(count) books"
    }
}

extension AuthorView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if TableSection(rawValue: indexPath.section) == .books {
            delegate?.authorView(self, didSelectBookAt: indexPath.row)
        }
    }
}

extension AuthorView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return author == nil ? 0 : TableSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let author = author else { return 0 }

        switch TableSection(rawValue: section) {
        case .info: return 1
        case .books: return author.books.count
        case .none: return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TableSection(rawValue: section) == .books ? "Books" : nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let author = author else { return UITableViewCell() }
        
        switch TableSection(rawValue: indexPath.section) {
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellId, for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = author.fullName
            content.textProperties.font = .preferredFont(forTextStyle: .title3)
            content.secondaryText = booksCountText(author.books.count)
            content.secondaryTextProperties.color = .secondaryLabel
            cell.contentConfiguration = content
            cell.selectionStyle = .none
            return cell
            
        case .books:
            let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.reuseId, for: indexPath) as! BookCell
            cell.configure(book: author.books[indexPath.row])
            return cell
            
        case .none:
            fatalError("is not conform TableSection cases")
        }
    }
}

