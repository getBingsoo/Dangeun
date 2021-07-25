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

    enum DataInfo {
        static let host = "https://www.daangn.com"
        static let searchUrl = "/search"
    }

    let network = Network()

    /// 리스트 fetch
    func fetchProducts(searchText: String = "") -> Observable<[Product]> {
        return Observable.create { [weak self] observer -> Disposable in
            let urlString = "\(DataInfo.host)\(DataInfo.searchUrl)/\(searchText)"
            guard let encodedString = urlString.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ), let url = URL(string: encodedString) else {
                return Disposables.create()
            }

            self?.network.send(url: url) { (result: Result<String, NetworkError>) in
                switch result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let result):
                        do {
                            var productList: [Product] = []
                            let result = try SwiftSoup.parse(result)

                            let elements = try result.select("#flea-market-wrap > article")
                            _ = try elements.map { element in

                                // link
                                let link = try element.select(".flea-market-article-link").first()?.attr("href") ?? ""

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
                                    Product(
                                        nickName: ""
                                        , category: ""
                                        , title: title
                                        , price: price
                                        , location: regionName
                                        , content: content
                                        , link: link
                                        , images: [photoUrl]
                                    )
                                )
                            }

                            observer.onNext(productList)
                            observer.onCompleted()
                        } catch {
                            observer.onError(error)
                        }
                }
            }
            return Disposables.create()
        }
    }

    /// 상세 fetch
    func fetchProductDetail(link: String) -> Observable<Product> {
        return Observable.create { [weak self] observer -> Disposable in
            let urlString = "\(DataInfo.host)\(link)"
            guard let encodedString = urlString.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ), let url = URL(string: encodedString) else {
                return Disposables.create()
            }

            self?.network.send(url: url) { (result: Result<String, NetworkError>) in
                switch result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let result):
                        do {
                            let result = try SwiftSoup.parse(result)

                            let title = try result.select("#article-title").text()
                            let price = try result.select("#article-price").text()
                            let images = try result.select(".image-wrap").array().map { element in
                                try element.select("img").attr("data-lazy")
                            }

                            let nickName = try result.select("#nickname").text()
                            let region = try result.select("#region-name").text()
                            let category = try result.select("#article-category").text()
                            let content = try result.select("#article-detail").text()

                            let product = Product(
                                nickName: nickName
                                , category: category
                                , title: title
                                , price: price
                                , location: region
                                , content: content
                                , link: urlString
                                , images: images
                            )
                            observer.onNext(product)
                            observer.onCompleted()
                        } catch {
                            observer.onError(error)
                        }
                }
            }

            return Disposables.create()
        }

    }
}
