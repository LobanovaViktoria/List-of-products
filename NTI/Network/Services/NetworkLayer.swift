//
//  NetworkLayer.swift
//  NTI
//
//  Created by Viktoria Lobanova on 12.02.2024.
//

import Foundation

final class NetworkLayer {
    
    //MARK: - Properties
    private let baseURLString = "https://vkus-sovet.ru/api/"
    private let session = URLSession.shared
    
    //MARK: - Methods
    func getCategoriesList(
        completion: @escaping (Result<[Category],
                               NetworkLayerError>
        ) -> Void) {
        let getURLResult = getUrl(
            forRequestType: .categoriesList,
            menuID: "")
        switch getURLResult {
        case .success(let url):
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let task = session.dataTask(with: request) {
                [weak self] data, response, error in
                guard let self, let response else {
                    completion(.failure(.unknownError))
                    return
                }
                let responseResult = self.handle(response: response)
                switch responseResult {
                case .success(_):
                    if error != nil {
                        completion(.failure(.networkError))
                        return
                    }
                    if let data {
                        let decoder = JSONDecoder()
                        if let categories = try? decoder.decode(
                            MenuResponse.self, from: data) {
                            completion(.success(categories.menuList))
                        } else {
                            completion(.failure(.decodingError))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            task.resume()
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func getDetailList(
        menuID: String,
        completion: @escaping (Result<[Detail],NetworkLayerError>
        ) -> Void) {
        let getURLResult = getUrl(
            forRequestType: .detailList,
            menuID: menuID)
        switch getURLResult {
        case .success(let url):
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let task = session.dataTask(with: request) {
                [weak self] data, response, error in
                guard let self, let response else {
                    completion(.failure(.unknownError))
                    return
                }
                let responseResult = self.handle(response: response)
                switch responseResult {
                case .success(_):
                    if error != nil {
                        completion(.failure(.networkError))
                        return
                    }
                    if let data {
                        let decoder = JSONDecoder()
                        if let details = try? decoder.decode(
                            DetailMenuResponse.self, from: data
                        ) {
                            completion(.success(details.menuList))
                        } else {
                            completion(.failure(.decodingError))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            task.resume()
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func getUrl(
        forRequestType type: RequestType,
        menuID: String
    ) -> Result<URL, NetworkLayerError> {
        var urlString: String
        switch type {
        case .categoriesList:
            urlString = baseURLString + type.rawValue
        case .detailList:
            urlString = baseURLString + type.rawValue+"?menuID="+menuID
        }
        guard let url = URL(string: urlString) else {
            return .failure(.wrongURL)
        }
        return .success(url)
    }
    
    private func handle(
        response: URLResponse
    ) -> Result<Void, NetworkLayerError> {
        guard let response = response as? HTTPURLResponse,
              let code = HTTPResponseCode(
                rawValue: response.statusCode
              ) else {
            return .failure(.wrongResponseType)
        }
        switch code {
        case .success:
            return .success(())
        case .serverError, .notFound:
            return .failure(.serverError)
        }
    }
}

//MARK: - Enums
enum HTTPResponseCode: Int {
    case success = 200
    case notFound = 404
    case serverError = 500
}

enum NetworkLayerError: Error {
    case wrongURL
    case networkError
    case decodingError
    case unknownError
    case wrongResponseType
    case serverError
    
    var errorText: String {
        switch self {
        case.wrongURL:
            "Неправильная ссылка, проверьте правильность ссылки"
        default:
            "Сервер не вернул данные, попробуйте позже"
        }
    }
}

enum RequestType: String {
    case categoriesList = "getMenu.php"
    case detailList = "getSubMenu.php"
}
