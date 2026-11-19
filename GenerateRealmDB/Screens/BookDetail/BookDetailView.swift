import UIKit

protocol BookDetailViewDelegate: AnyObject {
    func bookDetailViewDidTapAuthor(_ view: BookDetailView)
}

final class BookDetailView: UIView {

    weak var delegate: BookDetailViewDelegate?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let authorCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "AUTHOR"
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()

    private let booksCountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var authorVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [authorNameLabel, booksCountLabel])
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()

    private lazy var authorHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [authorVStack, chevronImageView])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false
        return stack
    }()

    private lazy var authorCardView: HighlightCardView = {
        let view = HighlightCardView()
        view.backgroundColor = .secondarySystemGroupedBackground
        view.layer.cornerRadius = 12
        view.layer.cornerCurve = .continuous
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(authorCardTapped), for: .touchUpInside)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(book: Book, author: Author) {
        titleLabel.text = book.title
        yearLabel.text = "Published in \(book.year)"
        authorNameLabel.text = author.fullName
        booksCountLabel.text = booksCountText(author.books.count)
    }

    private func setupLayout() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(authorCaptionLabel)
        contentView.addSubview(authorCardView)
        authorCardView.addSubview(authorHStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            yearLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            authorCaptionLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 24),
            authorCaptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorCaptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            authorCardView.topAnchor.constraint(equalTo: authorCaptionLabel.bottomAnchor, constant: 6),
            authorCardView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorCardView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            //привʼязка до низу
            authorCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            authorHStack.topAnchor.constraint(equalTo: authorCardView.topAnchor, constant: 14),
            authorHStack.bottomAnchor.constraint(equalTo: authorCardView.bottomAnchor, constant: -14),
            authorHStack.leadingAnchor.constraint(equalTo: authorCardView.leadingAnchor, constant: 16),
            authorHStack.trailingAnchor.constraint(equalTo: authorCardView.trailingAnchor, constant: -16),

            chevronImageView.widthAnchor.constraint(equalToConstant: 12),
            chevronImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }

    @objc private func authorCardTapped() {
        delegate?.bookDetailViewDidTapAuthor(self)
        print("BookDetailView: authorCardTapped")
    }

    private func booksCountText(_ count: Int) -> String {
        return count == 1 ? "1 book" : "\(count) books"
    }
}

final class HighlightCardView: UIControl {
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: isHighlighted ? 0 : 0.3) {
                self.backgroundColor = self.isHighlighted ? .gray : .secondarySystemGroupedBackground
            }
        }
    }
}
