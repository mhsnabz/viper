//
//  UIView+Extension.swift
//  Viper-Sample
//
//  Created by srbrt on 21.02.2024.
//

import Foundation
import UIKit

// Extension of UIView to add additional properties for corner radius, border color, and border width.
extension UIView {
    // This property allows setting the corner radius of a view directly from Interface Builder.
    @IBInspectable var cornerRadius: CGFloat {
        // Getter for the corner radius property.
        get {
            return layer.cornerRadius // Returns the current corner radius value.
        }
        // Setter for the corner radius property.
        set {
            layer.cornerRadius = newValue // Sets the corner radius of the view's layer.
            layer.masksToBounds = newValue > 0 // Clips subviews to the rounded corners if corner radius is greater than 0.
        }
    }

    // This property allows setting the border color of a view directly from Interface Builder.
    @IBInspectable var borderColor: UIColor? {
        // Getter for the border color property.
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color) // Returns the current border color as a UIColor.
            }
            return nil // Returns nil if there is no border color set.
        }
        // Setter for the border color property.
        set {
            layer.borderColor = newValue?.cgColor // Sets the border color of the view's layer.
        }
    }

    // This property allows setting the border width of a view directly from Interface Builder.
    @IBInspectable var borderWidth: CGFloat {
        // Getter for the border width property.
        get {
            return layer.borderWidth // Returns the current border width value.
        }
        // Setter for the border width property.
        set {
            layer.borderWidth = newValue // Sets the border width of the view's layer.
        }
    }
}
