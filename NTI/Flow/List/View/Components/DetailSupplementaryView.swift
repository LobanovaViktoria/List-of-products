//
//  DetailSupplementaryView.swift
//  NTI
//
//  Created by Viktoria Lobanova on 11.02.2024.
//

import UIKit

class DetailSupplementaryView: UICollectionReusableView {
    
    static let identifier = "header"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fontColor.whiteNTI
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(category: String) {
        titleLabel.text = category
    }
}
