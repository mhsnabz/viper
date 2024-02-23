//
//  SplashInterfaces.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//
import CoreLocation
import UIKit

/// Interface for the wireframe responsible for coordinating navigation in the splash screen.
protocol SplashWireframeInterface: WireframeInterface {
    /// Navigates to the main module of the application.
    func navigateToMain()
}

/// Interface for the view responsible for displaying the splash screen.
protocol SplashViewInterface: ViewInterface {}

/// Interface for the presenter responsible for handling business logic and interactions for the splash screen.
protocol SplashPresenterInterface: PresenterInterface {
    /// Requests the user's location.
    func getLocation()
}

/// Interface for the formatter responsible for formatting data in the splash screen.
protocol SplashFormatterInterface: FormatterInterface {}

/// Interface for the interactor responsible for handling business logic in the splash screen.
protocol SplashInteractorInterface: InteractorInterface {}
