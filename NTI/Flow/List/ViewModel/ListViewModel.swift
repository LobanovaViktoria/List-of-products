//
//  ListViewModel.swift
//  NTI
//
//  Created by Viktoria Lobanova on 12.02.2024.
//

import Foundation

final class ListViewModel: NSObject {
    
    //MARK: - Properties
    private let service = NetworkLayer()
    private(set) var categories: [Category] = []
    private(set) var details: [Detail] = []
    var selectedCategory: Category? {
        didSet {
            loadDetail(menuID: selectedCategory?.menuID ?? "")
        }
    }
    var onChange: (() -> Void)?
    var onError: ((NetworkLayerError) -> Void)?
    var onLoadingStarted: (() -> Void)?
    var onLoadingFinished: (() -> Void)?
    
    
    //MARK: - Init
    override init() {
        super.init()
    }
    
    
    //MARK: - Load
    func updateData() {
        loadData()
    }
    
    private func loadData() {
        onLoadingStarted?()
        service.getCategoriesList() { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let success):
                        self?.categories = success
                        if  self?.selectedCategory == nil {
                            self?.selectedCategory = self?.categories.first
                        }
                        DispatchQueue.main.async {
                            self?.onLoadingFinished?()
                            self?.onChange?()
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.onError?(error)
                        }
                    }
                }
            }
        }
    
    func loadDetail(menuID: String) {
        onLoadingStarted?()
        service.getDetailList(menuID: selectedCategory?.menuID ?? "") { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let success):
                        self?.details = success
                        DispatchQueue.main.async {
                            self?.onLoadingFinished?()
                            self?.onChange?()
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.onError?(error)
                        }
                    }
                }
            }
        }
    }
