//
//  ListViewController.swift
//  NTI
//
//  Created by Viktoria Lobanova on 10.02.2024.
//

import UIKit

final class ListViewController: UIViewController {
    
    // - MARK: Properties
    private var categories: [Category] {
        viewModel.categories
    }
    private var details: [Detail] {
        viewModel.details
    }
    private let baseImageURL = "https://vkus-sovet.ru"
    private let viewModel: ListViewModel
    private let lineSpacingForCategoryCollection: CGFloat = 16
    private let interItemSpacingForCategoryCollection: CGFloat = 10
    private let heightCategoryCollectionCell: CGFloat = 140
    private var widthCategoryCollectionCell: CGFloat {
        (UIScreen.main.bounds.width - (padding + 
        2 * lineSpacingForCategoryCollection)) / 3
    }
    
    private let lineSpacingForDetailCollection: CGFloat = 30
    private let interItemSpacingForDetailCollection: CGFloat = 16
    private let heightDetailCollectionCell: CGFloat = 290
    private var widthDetailCollectionCell: CGFloat {
        (UIScreen.main.bounds.width - (padding * 2 +
        interItemSpacingForDetailCollection)) / 2
    }
    
    // - MARK: UI
    private lazy var topView = TopView()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .fontColor.blackNTI
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var categoryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .background.grayNTI
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var detailCollection: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .background.grayNTI
        collectionView.register(
            DetailCollectionViewCell.self,
            forCellWithReuseIdentifier: DetailCollectionViewCell.identifier
        )
        collectionView.register(
            DetailSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DetailSupplementaryView.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // - MARK: Init
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.onChange = {
            self.categoryCollection.reloadData()
            self.detailCollection.reloadData()
        }
        viewModel.onError = { [weak self] error in
            self?.showErrorAlert(error: error)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background.grayNTI
        
        viewModel.updateData()
        viewModel.onLoadingStarted = self.startAnimating
        viewModel.onLoadingFinished = self.stopAnimating
       
        categoryCollection.dataSource = self
        categoryCollection.delegate = self
        detailCollection.dataSource = self
        detailCollection.delegate = self
        
        addSubviews()
        setupLayout()
    }
    
    // - MARK: Private Methods
    private func addSubviews() {
        view.addSubview(topView)
        view.addSubview(activityIndicator)
        view.addSubview(categoryCollection)
        view.addSubview(detailCollection)
    }
    
    private func setupLayout() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: heightTopView),
        
            categoryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            categoryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollection.heightAnchor.constraint(equalToConstant: heightCategoryCollectionCell),
            categoryCollection.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 15),
            
            detailCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            detailCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailCollection.topAnchor.constraint(equalTo: categoryCollection.bottomAnchor, constant: 20),
            
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func startAnimating() {
        activityIndicator.startAnimating()
    }

    private func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
    private func showErrorAlert(error: NetworkLayerError) {
        let alertController = UIAlertController(
            title: "Ошибка",
            message: error.errorText,
            preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(
                title: "Отмена",
                style: .default,
                handler: nil))
        alertController.addAction(
            UIAlertAction(
                title: "Повторить",
                style: .default,
                handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.updateData()
        }))
        present(alertController, animated: true, completion: nil)
    }
}

// - MARK: Extension UICollectionViewDataSource
extension ListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if collectionView == categoryCollection {
            return categories.count
        }
        return details.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == categoryCollection {
            return 1
        }
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = categoryCollection.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath) as? CategoryCollectionViewCell
        else { return CategoryCollectionViewCell() }
        
        if collectionView == categoryCollection {
            let category = categories[indexPath.row]
            let isSelectedCategory = category == viewModel.selectedCategory
            if let imageURLString = category.image,
               let imageURL = URL(string: baseImageURL + imageURLString) {
                cell.configure(
                    image: imageURL,
                    name: category.name,
                    count: "\(category.subMenuCount)" + 
                        String.localizedStringWithFormat(
                        NSLocalizedString("numberOfProducts",
                        comment: "количество товаров"),
                        category.subMenuCount),
                    backgroundColor: isSelectedCategory ?
                        .background.selectedCell ?? .blue :
                        .background.unselectedCell ?? .gray)
                cell.contentView.layer.cornerRadius = radius
            }
        }
            if collectionView == detailCollection {
                guard let cell2 = detailCollection.dequeueReusableCell(
                    withReuseIdentifier: DetailCollectionViewCell.identifier,
                    for: indexPath) as? DetailCollectionViewCell
                else { return DetailCollectionViewCell() }
                if details.isEmpty {
                    return UICollectionViewCell()
                }
                let detail = details[indexPath.row]
                if let imageURLString = detail.image,
                   let imageURL = URL(string: baseImageURL + imageURLString) {
                    cell2.configure(
                        image: imageURL,
                        name: detail.name,
                        ingredients: detail.content,
                        price: String((Float(detail.price)?.asRUBCurrency ?? "") + " /"),
                        weight: " " + (detail.weight ?? ""),
                        spicy: detail.spicy)
                }
                return cell2
            }
        return cell
        }
}

// - MARK: Extension UICollectionViewDelegate
extension ListViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if collectionView == categoryCollection {
            let previousSelection = viewModel.selectedCategory
            var previousIndexPath = IndexPath(item: 0, section: 0)
            if let previousSelection {
                let index = categories.firstIndex(of: previousSelection) ?? 0
                previousIndexPath = IndexPath(item: index, section: 0)
            }
            viewModel.selectedCategory = categories[indexPath.row]
            UIView.performWithoutAnimation {
                collectionView.reloadItems(at: [previousIndexPath, indexPath])
            }
            detailCollection.reloadData()
            detailCollection.scrollToItem(
                at: IndexPath(row: 0, section: 0),
                at: .bottom,
                animated: false)
        }
    }
}

// - MARK: Extension UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == detailCollection {
            return CGSize(width: widthDetailCollectionCell,
                   height: heightDetailCollectionCell)
        } else {
            return CGSize(width: widthCategoryCollectionCell,
                   height: heightCategoryCollectionCell)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        if collectionView == detailCollection {
            return lineSpacingForDetailCollection
        } else {
            return lineSpacingForCategoryCollection
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        if collectionView == detailCollection {
            return interItemSpacingForDetailCollection
        } else {
            return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if collectionView == categoryCollection {
            return UICollectionReusableView()
        }
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "header"
        case UICollectionView.elementKindSectionFooter:
            id = "footer"
        default:
            id = ""
        }
            guard let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: id,
                for: indexPath
            ) as? DetailSupplementaryView else {
                return UICollectionReusableView()
            }

            view.configureHeader(
                category: viewModel.selectedCategory?.name ?? ""
                )
        return view
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if collectionView == categoryCollection {
            return .zero
        }
        return CGSize(
            width: collectionView.frame.width,
            height: 50)
    }
}
