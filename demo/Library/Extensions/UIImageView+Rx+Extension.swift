//
//  UIImageView+Rx+Extension.swift
//  demo
//
//  Created by Marko Aras on 18/11/2017.
//  Copyright © 2017 MITURF. All rights reserved.
//

import Foundation
import RxSwift
import UIKit
import RxCocoa

extension Reactive where Base: UIImageView {
    public var isAnimating: Binder<Bool> {
        return Binder(base) { imageView, image in
            if !imageView.isAnimating {
                imageView.startAnimating()
            } else {
                imageView.stopAnimating()
            }
        }
    }
}

