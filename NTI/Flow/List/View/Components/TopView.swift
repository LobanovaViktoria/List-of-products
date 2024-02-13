//
//  TopView.swift
//  NTI
//
//  Created by Viktoria Lobanova on 10.02.2024.
//

import UIKit

final class TopView: UIView {
    
    // - MARK: UI
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .background.grayNTI
        return view
    }()
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "circle.hexagongrid")
        image.tintColor = .fontColor.whiteNTI
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameCompany: UILabel = {
        let title = UILabel()
        title.text = "Vkussovet".uppercased()
        title.font = .systemFont(ofSize: 20, weight: .bold)
        title.textColor = .fontColor.whiteNTI
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var phoneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(
            systemName: "phone")?
            .resizedImageWithinRect(
                rectSize: CGSize(
                    width: 35,
                    height: 35)
            ).withTintColor(UIColor.whiteNTI), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // - MARK: Init
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - MARK: Private methods
    private func addSubviews() {
        addSubview(backgroundView)
        backgroundView.addSubview(icon)
        backgroundView.addSubview(nameCompany)
        backgroundView.addSubview(phoneButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            icon.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: padding),
            icon.heightAnchor.constraint(equalToConstant: 35),
            icon.widthAnchor.constraint(equalToConstant: 35),
            
            nameCompany.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            nameCompany.trailingAnchor.constraint(equalTo: phoneButton.leadingAnchor),
            nameCompany.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 5),
            
            phoneButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            phoneButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            phoneButton.heightAnchor.constraint(equalToConstant: 35),
            phoneButton.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
}
