//
//  Gradient+Extension.swift
//  Viper-Sample
//
//  Created by srbrt on 21.02.2024.
//

import UIKit

// This class represents a custom UIView with a gradient background.
@IBDesignable
class GradientView: UIView {
    // Private property to hold the gradient layer.
    private var gradientLayer: CAGradientLayer!

    // IBInspectable property to set the start color of the gradient. Default value is UIColor(named: "start")!.
    @IBInspectable var startColor: UIColor = .init(named: "start")! {
        didSet {
            setNeedsLayout() // Marks the view as needing layout when the start color is set.
        }
    }

    // IBInspectable property to set the end color of the gradient. Default value is UIColor(named: "end")!.
    @IBInspectable var endColor: UIColor = .init(named: "end")! {
        didSet {
            setNeedsLayout() // Marks the view as needing layout when the end color is set.
        }
    }

    // Overrides the layerClass property to return CAGradientLayer.
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    // Overrides the layoutSubviews method to update the gradient layer's frame and colors.
    override func layoutSubviews() {
        super.layoutSubviews()
        // If the gradientLayer is nil, create a new CAGradientLayer and add it as a sublayer.
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            gradientLayer.frame = bounds
            gradientLayer.locations = [0.5, 1.0] // Gradient locations to control color distribution.
            layer.insertSublayer(gradientLayer, at: 0)
        }
        // Set the colors of the gradient layer based on the startColor and endColor properties.
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
