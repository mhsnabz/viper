//
//  LoadingView.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//

import Foundation
import UIKit

public protocol LoadingView: AnyObject {
    // Animator property representing a custom loading indicator
    var animator: CustomProgress { get }

    // Method to start the loading animation
    func startLoading()

    // Method to stop the loading animation
    func stop()
}

public extension LoadingView where Self: UIViewController {
    func startLoading() {
        // Perform UI updates on the main thread asynchronously
        DispatchQueue.main.async { [weak self] in
            // Check if self and the window are available
            if let self = self, let window = UIApplication.shared.windows.last {
                // Set the frame of the animator to cover the entire screen
                self.animator.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                // Add the animator to the window
                window.addSubview(self.animator)
                // Start the animation
                self.animator.startAnmation()
            }
        }
    }

    // Implementation of the stopLoading method for view controllers conforming to LoadingView
    func stop() {
        // Perform UI updates on the main thread asynchronously
        DispatchQueue.main.async { [weak self] in
            // Remove the animator from its superview
            self?.animator.removeFromSuperview()
        }
    }
}
