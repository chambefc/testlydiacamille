//
//  ProgressiveImageView.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import UIKit
import SwiftData

/// Allows to display an image, from the lowest resolution available to the biggest.
final class ProgressiveImageView: UIImageView {

    // The maximum size to be displayed
    private var maxSize: DisplaySize

    // The last fetched DisplaySize image
    private var currentDisplaySize: DisplaySize = .thumbnail

    // Current performing call (for eventual cancellation)
    private var task: Task<Void, Error>?

    init(size: DisplaySize) {
        self.maxSize = size
        super.init(image: nil)
        self.clipsToBounds = true
        self.backgroundColor = Theme.ProfilePicture.backgroundColor
        self.tintColor = Theme.ProfilePicture.borderColor
        self.layer.borderWidth = Theme.ProfilePicture.borderWidth
        self.layer.borderColor = Theme.ProfilePicture.borderColor.cgColor
        self.contentMode = .scaleAspectFit

        registerForTraitChanges([UITraitUserInterfaceStyle.self]) {
            (self: Self, previousTraitCollection: UITraitCollection) in
            self.layer.borderColor = Theme.ProfilePicture.borderColor.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.layer.bounds.width / 2
        super.layoutSubviews()
    }
    
    // Given an User Picture, loading from the lowest resolution to the biggest while staying less or equal to the set maximum image size
    public func loadPicture(picture: User.Picture?) {
        
        guard let picture = picture else {
            return
        }
        
        var availableSizes = [ImageStep]()
        if let thumbnail = picture.thumbnail { availableSizes.append(ImageStep(size: .thumbnail, path: thumbnail)) }
        if let medium = picture.medium { availableSizes.append(ImageStep(size: .medium, path: medium)) }
        if let large = picture.large { availableSizes.append(ImageStep(size: .large, path: large)) }

        task = Task { @MainActor in

            if ReachabilityManager.shared.isNetworkReachable == false {
                await loadBiggestCachedPicture(availableSizes: availableSizes)
                return
            }

            for step in availableSizes {
                if step.size > self.maxSize && self.image != nil {
                    return
                }
                do {
                    let imageData = try await NetworkClient().executeDataRequest(.init(url: URL(string: step.path)!))
                    
                    // For local storage
                    step.data = imageData
                    await PersistencyManager.shared.addImageStep(step: step)

                    self.image = UIImage(data: imageData)
                }
            }
        }
    }

    /// Fetches locally available picture and sets the biggest resolution as the current image
    /// - Parameter availableSizes: The provided available Sizes from the User model
    private func loadBiggestCachedPicture(availableSizes: [ImageStep]) async {
        var localSteps = [ImageStep]()
        for size in availableSizes {
            if let step = await PersistencyManager.shared.getCachedImageStep(path: size.path) {
                localSteps.append(step)
            }
        }
        let biggestFilledStep = localSteps
            .sorted(by: { $0.size > $1.size })
            .filter({ $0.data != nil })
            .first
        if let data = biggestFilledStep?.data,
           let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = Theme
                .ProfilePicture
                .placeHolder?
                .withTintColor(
                    Theme.ProfilePicture.borderColor,
                    renderingMode: .alwaysTemplate
                )
        }
    }

    // Resets the ProgressiveImageView to its original state and cancels all pending operations
    func reset() {
        self.task?.cancel()
        self.currentDisplaySize = .thumbnail
        self.image = nil
    }
}


extension ProgressiveImageView {

    // The size of the image
    enum DisplaySize: Codable, Comparable {
        case thumbnail
        case medium
        case large
    }

    // Represents a resolution step associated with the adequate URLPath as String
    @Model
    class ImageStep {
        let size: DisplaySize
        @Attribute(.unique) let path: String
        @Attribute(.externalStorage) var data: Data?

        init(size: DisplaySize, path: String, data: Data? = nil) {
            self.size = size
            self.path = path
            self.data = data
        }
    }
}
