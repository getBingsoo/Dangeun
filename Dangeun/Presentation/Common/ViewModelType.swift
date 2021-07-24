//
//  ViewModelType.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
