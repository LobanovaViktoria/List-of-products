//
//  DetailCollectionViewCell.swift
//  NTI
//
//  Created by Viktoria Lobanova on 10.02.2024.
//

import UIKit
import Kingfisher

final class DetailCollectionViewCell: UICollectionViewCell {

    // - MARK: Properties
    static let identifier = "DetailCollectionViewCell"
    
    private let heightButtonPutIntoCart: CGFloat = 50
    
    // - MARK: UI
    private lazy var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = radius
        imageView.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var detailNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontColor.whiteNTI
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontColor.lightGrayNTI
        label.textAlignment = .center
        label.numberOfLines = 6
        label.font = .systemFont(ofSize: 9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontColor.whiteNTI
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontColor.lightGrayNTI
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var flameImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "flame")
        image.tintColor = .fontColor.redNTI
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .background.blackNTI
        view.layer.cornerRadius = radius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewForPriceAndWeight: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var putIntoCartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .background.blueNTI
        button.setTitle("В корзину", for: .normal)
        button.setTitleColor(.fontColor.whiteNTI, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.layer.cornerRadius = radius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(putIntoCartButtonTapped),
            for: .touchUpInside)
        return button
    }()
    
    // - MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // - MARK: Methods
    private func addSubview() {
        contentView.addSubview(background)
        background.addSubview(detailImageView)
        background.addSubview(detailNameLabel)
        background.addSubview(ingredientsLabel)
        background.addSubview(viewForPriceAndWeight)
        viewForPriceAndWeight.addSubview(priceLabel)
        viewForPriceAndWeight.addSubview(weightLabel)
        viewForPriceAndWeight.addSubview(flameImageView)
        contentView.addSubview(putIntoCartButton)
    }
    
    private func setupLayout() {
        
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: contentView.topAnchor),
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(heightButtonPutIntoCart / 2)),

            detailImageView.bottomAnchor.constraint(equalTo: background.bottomAnchor),
            detailImageView.leadingAnchor.constraint(equalTo: background.leadingAnchor),
            detailImageView.trailingAnchor.constraint(equalTo: background.trailingAnchor),
            detailImageView.heightAnchor.constraint(equalToConstant: (contentView.bounds.height - heightButtonPutIntoCart / 2) / 2),

            detailNameLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 2),
            detailNameLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -(padding / 2)),
            detailNameLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: padding / 2),
            detailNameLabel.heightAnchor.constraint(equalToConstant: 35),
            detailNameLabel.widthAnchor.constraint(equalTo: background.widthAnchor),

            ingredientsLabel.topAnchor.constraint(equalTo: detailNameLabel.bottomAnchor, constant: 3),
            ingredientsLabel.heightAnchor.constraint(equalToConstant: 55),
            ingredientsLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -(padding / 2)),
            ingredientsLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: padding / 2),

            viewForPriceAndWeight.bottomAnchor.constraint(equalTo:detailImageView.topAnchor, constant: -8),
            viewForPriceAndWeight.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            viewForPriceAndWeight.heightAnchor.constraint(equalToConstant: 18),
            viewForPriceAndWeight.widthAnchor.constraint(equalTo: background.widthAnchor),

            priceLabel.centerYAnchor.constraint(equalTo: viewForPriceAndWeight.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: viewForPriceAndWeight.centerXAnchor),
            priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: viewForPriceAndWeight.leadingAnchor, constant: padding),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            weightLabel.centerYAnchor.constraint(equalTo: viewForPriceAndWeight.centerYAnchor),
            weightLabel.leadingAnchor.constraint(equalTo: viewForPriceAndWeight.centerXAnchor),
            weightLabel.trailingAnchor.constraint(greaterThanOrEqualTo: flameImageView.leadingAnchor, constant: 0),
            weightLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            flameImageView.centerYAnchor.constraint(equalTo: viewForPriceAndWeight.centerYAnchor),
            flameImageView.trailingAnchor.constraint(equalTo: viewForPriceAndWeight.trailingAnchor, constant: -8),
            flameImageView.heightAnchor.constraint(equalToConstant: 20),
            flameImageView.widthAnchor.constraint(equalToConstant: 20),
            
            putIntoCartButton.bottomAnchor.constraint(equalTo:contentView.bottomAnchor),
            putIntoCartButton.heightAnchor.constraint(equalToConstant: heightButtonPutIntoCart),
            putIntoCartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            putIntoCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
    
    func configure(
        image: URL,
        name: String,
        ingredients: String,
        price: String,
        weight: String?,
        spicy: String?
    ) {
        detailImageView.kf.setImage(with: image)
        detailNameLabel.text = name
        ingredientsLabel.text = ingredients
        priceLabel.text = price
        weightLabel.text = weight != nil ? weight : ""
        flameImageView.isHidden = spicy != "Y" ? true : false
    }
    
    @objc private func putIntoCartButtonTapped() {
    }
}
