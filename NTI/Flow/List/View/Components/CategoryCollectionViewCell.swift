//
//  CategoryCollectionCell.swift
//  NTI
//
//  Created by Viktoria Lobanova on 10.02.2024.
//

import UIKit
import Kingfisher

final class CategoryCollectionViewCell: UICollectionViewCell {

    // - MARK: Properties
    static let identifier = "CategoryCollectionCell"
    
    // - MARK: UI
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = radius
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var categoryName: UILabel = {
        let label = UILabel()
        label.textColor = .fontColor.whiteNTI
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontColor.lightGrayNTI
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // - MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryName)
        contentView.addSubview(countLabel)
    
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height / 2),

            categoryName.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 2),
            categoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            categoryName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            categoryName.heightAnchor.constraint(equalToConstant: 35),

            countLabel.topAnchor.constraint(equalTo: categoryName.bottomAnchor, constant: 2),
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // - MARK: Configure
    func configure(
        image: URL,
        name: String,
        count: String,
        backgroundColor: UIColor
        ) {
            categoryImageView.kf.setImage(with: image)
            categoryName.text = name
            countLabel.text = count
            contentView.backgroundColor = backgroundColor
    }
}
