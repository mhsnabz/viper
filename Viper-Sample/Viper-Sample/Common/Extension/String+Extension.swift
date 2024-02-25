//
//  String+Extension.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//

import Foundation
import UIKit

extension String {
    func width(forFont font: UIFont = UIFont(name: "Nonito-Regular", size: 12) ?? .systemFont(ofSize: 12)) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}
