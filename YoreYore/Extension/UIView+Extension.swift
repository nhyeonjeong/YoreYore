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
    // view의 점선그리기
    func setLineDot(color: UIColor?, radius: CGFloat){
        print("setLineDot")
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.lineWidth = 10
        borderLayer.lineDashPattern = [10, 10]
        borderLayer.frame = self.bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath

        self.layer.addSublayer(borderLayer)
    }
}
