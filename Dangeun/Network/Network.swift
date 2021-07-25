//
//  Network.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/26.
//

import Foundation

class Network {

    /// url로 통신
    func send(url: URL, completion: @escaping (Result<String, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                completion(.failure(.serverError(error: error)))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.responseError))
                return
            }

            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.statusCodeError(code: response.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.parsingError))
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                completion(.success(responseString))
            } else {
                completion(.failure(.parsingError))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case serverError(error: Error)
    case responseError
    case statusCodeError(code: Int)
    case parsingError
}
