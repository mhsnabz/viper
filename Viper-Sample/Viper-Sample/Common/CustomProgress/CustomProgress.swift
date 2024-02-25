//
//  CustomProgress.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//

import Foundation
import UIKit
public class CustomProgress: UIView {
    @IBOutlet var indicatorView: UIActivityIndicatorView!

    func startAnmation() {
        indicatorView.startAnimating()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        if let subView = Bundle.main.loadNibNamed("CustomProgress", owner: self, options: nil)?[0] as? UIView {
            subView.frame = bounds
            addSubview(subView)
        }
    }
}
