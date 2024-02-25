//
//  UITextField+Extension.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//
import UIKit
extension UITextField {
    func setPlaceholderColor(_ color: UIColor) {
        var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: color]
        attributes[NSAttributedString.Key.font] = UIFont(name: "Nunito-Medium", size: 14)
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
    }
}
