//
//  Theme.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import UIKit

/// This class encapsulates every UI value to be easily changed
enum Theme {

    enum Navigation {
        static let titleColor: UIColor = UIColor.navigationTitle
        static let largeTitleFont: UIFont = UIFont(name: "WorkSans-SemiBold", size: 30)!
        static let smallTitleFont: UIFont = UIFont(name: "WorkSans-SemiBold", size: 20)!
    }
    
    enum Cell {
        static let borderWidth: CGFloat = 4.0
        static let cornerRadius: CGFloat = 10.0
        static let backgroundColor: UIColor = UIColor.cellBackground
        static let borderColor: UIColor = UIColor.cellBorder
        static let titleFont: UIFont = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        static let titleColor: UIColor = UIColor.cellTitle
        static let subtitleFont: UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        static let subtitleColor: UIColor = UIColor.cellSubTitle
    }
    
    enum Controller {
        static let backgroundImage: UIImage = UIImage(named: "mainBackground")!
    }
    
    enum ProfilePicture {
        static let borderWidth: CGFloat = 2.0
        static let backgroundColor: UIColor = UIColor.profilePictureBackground
        static let borderColor: UIColor = UIColor.profilePictureBorder
        static let placeHolder: UIImage? = UIImage(systemName: "person.circle.fill")
    }
    
    enum DetailsCell {
        static let font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        static let color: UIColor = UIColor.userDetailsCellText
        static let coordinates: UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    }

    enum NotificationBanner {
        public enum Background {
            static let info = UIColor.systemYellow
            static let error = UIColor.systemRed
        }

        public enum Text {
            static let info = UIColor.black
            static let error = UIColor.white
        }
    }

}
