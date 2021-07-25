//
//  DataManager.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/24.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftSoup

class DataManager {

//    func fetchProducts() -> Driver<[Product]> {
//        guard let path = Bundle.main.path(forResource: "DataExample", ofType: "json") else {
//            return Driver<[Product]>.empty()
//        }
//
//        guard let jsonString = try? String(contentsOfFile: path)
//              , let data = jsonString.data(using: .utf8) else {
//            return Driver<[Product]>.empty()
//        }
//
//        do {
//            let decoder = JSONDecoder()
//            let result = try decoder.decode(ProductResult.self, from: data)
//            let data = result.data
//            return Driver<[Product]>.just(data)
//        } catch {
//            print(error) // todo: 수정
//            return Driver<[Product]>.empty()
//        }
//    }

    func fetchProducts(searchText: String = "") -> Observable<[Product]> {

        return Observable.create { observer -> Disposable in

            let urlString = "https://www.daangn.com/search/\(searchText)"
            let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

            if let url = URL(string: encodedString) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    let responseString = String(data: data!, encoding: .utf8)
                    do {
                        var productList: [Product] = []
                        let result = try SwiftSoup.parse(responseString!)

                        let elements = try result.select("#flea-market-wrap > article")
                        _ = try elements.map { element in

                            // photo
                            let photos = try element.select(".card-photo")
                            let src = try photos.select("img")
                            let photoUrl = try src.attr("src")

                            // info
                            let info = try element.select(".article-info")
                            let title = try info.select(".article-title").text()
                            let content = try info.select(".article-content").text()
                            let regionName = try info.select(".article-region-name").text()
                            let price = try info.select(".article-price").text()

                            productList.append(
                                Product(title: title, price: price, location: regionName, content: content, images: [photoUrl])
                            )
                        }

                        observer.onNext(productList)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }.resume()

            }

            return Disposables.create()
        }

    }
}
