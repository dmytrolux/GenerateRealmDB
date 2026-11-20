//
//  BookCell.swift
//  GenerateRealmDB
//
//  Created by Дмитро on 19.11.2026.
//

import UIKit

final class BookCell: UITableViewCell {

    static let reuseId = "BookCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        authorLabel.text = nil
    }
    
    func configure(book: Book) {
          titleLabel.text = book.title
        accessoryType = .disclosureIndicator
        selectionStyle = .default
      }

    func configure(book: Book, author: Author) {
        titleLabel.text = book.title
        authorLabel.text = author.fullName
        accessoryType = .disclosureIndicator
        selectionStyle = .default
    }

    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)

        NSLayoutConstraint.activate([
           
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            // низ
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
