//
//  CustomImageView.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/24.
//

import UIKit

class CustomImageView: UIImageView {

    var imageUrl: String?

    func loadImage(from url: String, completion: ((UIImage?) -> ())? = nil) {
        self.image = nil
        self.imageUrl = url

        ImageLoader.loadImage(url: url) { image in
            DispatchQueue.main.async {
                if self.imageUrl == url {
                    self.image = image
                    completion?(image)
                }
            }
        }
    }
}
