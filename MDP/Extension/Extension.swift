//
//  Extension.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/16/26.
//

import UIKit

// MARK: - UIImageView Extension

extension UIImageView {
    func downloadImage(from imagePath: String?, size: String = "w500") {
        self.image = UIImage(systemName: Constants.defaultImage.rawValue)

        guard let imagePath = imagePath else {
            return
        }

        let imageBaseURL = "https://image.tmdb.org/t/p/\(size)"

        guard let imageURL = URL(string: imageBaseURL + imagePath) else {
            print("Log:: Invalid movie image URL")
            return
        }

        ImageManager.shared.fetchImage(for: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.image = image
                }
            case .failure(let error):
                print("Log:: Unable to fetch movie image \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.image = UIImage(systemName: Constants.defaultImage.rawValue)
                }
            }
        }
    }
}
