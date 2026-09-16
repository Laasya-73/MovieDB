//
//  MovieCell.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/15/26.
//

import UIKit

class MovieCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = Constants.movieCell.rawValue
    
    let containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let movieImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let movieRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - User Defined Methods
    
    func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(movieImage)
        containerView.addSubview(movieTitle)
        containerView.addSubview(movieRating)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            movieImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            movieImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            movieImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            movieImage.widthAnchor.constraint(equalToConstant: 100),
            movieImage.heightAnchor.constraint(equalToConstant: 140),
            
            movieTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            movieTitle.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 12),
            movieTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            movieRating.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10),
            movieRating.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            movieRating.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor),
            movieRating.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -12)
        ])
    }
}

//MARK: - Helper Methods

extension MovieCell {
    func configure(with movie: Movie?) {
        movieTitle.text = movie?.title
        movieRating.text = "\(Constants.ratingLabel.rawValue) \(movie?.voteAverage ?? 0)"
        movieImage.image = UIImage(systemName: Constants.defaultImage.rawValue)
        guard let posterPath = movie?.posterPath else {
            return
        }
        let imageURLString = Constants.baseImageUrl.rawValue + posterPath
        loadMovieImage(from: imageURLString)
    }
    
    func loadMovieImage(from urlString: String) {
        guard let imageURL = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            if let error = error {
                print("Failed to load image: \(error.localizedDescription)")
                return
            }

            guard let imageData = data, let downloadedImage = UIImage(data: imageData) else {
                return
            }
            
            DispatchQueue.main.async {
                self?.movieImage.image = downloadedImage
            }
        }.resume()
    }
}

/*
 Because MovieCell is registered using MovieCell.self, the table view creates the cell programmatically. Therefore I set up the cell UI inside init(style:reuseIdentifier:). If the cell were coming from a storyboard or XIB, then awakeFromNib() would be appropriate.
 
 MovieCell.configure(with:) receives one Movie object for the current table row and maps the model properties to the corresponding UI elements. The cell does not choose or fetch which movie to display. The ViewController provides the correct movie, and the cell is only responsible for presenting it.

 The movie API gives me only a relative posterPath, so I combine it with TMDB's base image URL to create the complete URL. I convert that string into a URL, use URLSession to download the image data, convert the returned Data into a UIImage, and then update the UIImageView on the main thread.
 */
