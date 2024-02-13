//
//  CategoryModel.swift
//  NTI
//
//  Created by Viktoria Lobanova on 12.02.2024.
//

import Foundation

struct MenuResponse: Codable {
    let status: Bool
    let menuList: [Category]
}

struct Category: Codable, Equatable {
    let menuID: String
    let image: String?
    let name: String
    let subMenuCount: Int
}

struct DetailMenuResponse: Codable {
    let status: Bool
    let menuList: [Detail]
}

struct Detail: Codable, Equatable {
    let id: String
    let image: String?
    let name: String
    let content: String
    let price: String
    let weight: String?
    let spicy: String?
}
