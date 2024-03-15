//
//  Extension+UIView.swift
//  YoreYore
//
//  Created by 남현정 on 2024/03/09.
//

import UIKit

extension UIView {
    static var identifier: String {
        String(describing: self)
    }
    // addSubView를 한번에
    func addViews(_ list: [UIView]) {
        list.forEach { view in
            self.addSubview(view)
        }
    }
}
