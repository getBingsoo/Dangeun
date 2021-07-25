//
//  ImageLoader.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/24.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageLoader {

    static func loadImage(url: String, completed: ((UIImage?) -> Void)?) {
        // 캐시에 있으면 캐시의 이미지 가져온다.
        if let image = imageCache.object(forKey: url as NSString) {
            completed?(image)
            return
        }

        if let imageUrl = URL(string: url) {
            URLSession.shared.dataTask(with: imageUrl) { (data, resonse, error) in
                if error != nil {
                    completed?(nil)
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url as NSString)
                    completed?(image)
                    return
                } else {
                    completed?(nil)
                    return
                }
            }.resume()
        } else {
            completed?(nil)
            return
        }
    }
}
