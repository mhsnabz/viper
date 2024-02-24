//
//  UIImageView+Extension.swift
//  Viper-Sample
//
//  Created by srbrt on 24.02.2024.
//

import Foundation
import SDWebImage
import UIKit

extension UIImageView {
    func loadIcon(iconId: String) {
        // Construct the URL for fetching the icon image
        if let newUrl = URL(string: String(format: ApiConstant.imageBaseUrl, iconId)) {
            // Set the activity indicator style
            sd_imageIndicator = SDWebImageActivityIndicator.white

            // Asynchronously load the image from the URL and set it to the image view
            sd_setImage(with: newUrl)
        }
    }
}
