//
//  NotificationBanner.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 17/02/2024.
//

import UIKit

/// Displays notifications on top of the screen
final class NotificationBanner {

    public enum AlertType {
        case info
        case error

        var backgroundColor: UIColor {
            switch self {
            case .info:
                return Theme.NotificationBanner.Background.info
            case .error:
                return Theme.NotificationBanner.Background.error
            }
        }

        var textColor: UIColor {
            switch self {
            case .info:
                return Theme.NotificationBanner.Text.info
            case .error:
                return Theme.NotificationBanner.Text.error
            }
        }
    }

    /// This method allows to display notifications on top of the screen
    /// - Parameters:
    ///   - text: The text to be displayed
    ///   - type: The type of message to convey e.g. Error or Info
    ///   - view: The view on which to display the notification
    ///   - completion: Called after the notification is finished displaying
    static public func display(
        text: String,
        type: AlertType = .error,
        in view: UIView,
        completion: (() -> Void)? = nil
    ) {
        let bannerView = UIView(frame: .zero)
        bannerView.backgroundColor = type.backgroundColor
        bannerView.alpha = 0.0
        bannerView.translatesAutoresizingMaskIntoConstraints = false

        let textLabel = UILabel()
        textLabel.textColor = type.textColor
        textLabel.text = text
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        let safeAreaInset = view.safeAreaInsets.top

        bannerView.addSubview(textLabel)
        view.addSubview(bannerView)

        bannerView.addConstraints([
            NSLayoutConstraint(item: textLabel, attribute: .bottom, relatedBy: .equal, toItem: bannerView, attribute: .bottom, multiplier: 1, constant: -12),
            NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal, toItem: bannerView, attribute: .leading, multiplier: 1, constant: 12),
            NSLayoutConstraint(item: textLabel, attribute: .trailing, relatedBy: .equal, toItem: bannerView, attribute: .trailing, multiplier: 1, constant: -12),
            NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: bannerView, attribute: .top, multiplier: 1, constant: 12 + safeAreaInset),
        ])

        view.addConstraints([
            NSLayoutConstraint(item: bannerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bannerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bannerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
        ])

        UIView.animate(withDuration: 0.5) {
            bannerView.alpha = 1.0
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 2) {
                bannerView.alpha = 0
            } completion: { _ in
                bannerView.removeFromSuperview()
                completion?()
            }
        }
    }
}
