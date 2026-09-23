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
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 18
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.10
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()

    let accentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemIndigo
        view.layer.cornerRadius = 2
        return view
    }()

    var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        imageView.image = UIImage(systemName: Constants.defaultImage.rawValue)
        return imageView
    }()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()

    let ratingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.15)
        view.layer.cornerRadius = 12
        return view
    }()

    var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .systemOrange
        return label
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 5
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
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(cardView)
        cardView.addSubview(movieImageView)
        cardView.addSubview(accentView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(ratingView)
        ratingView.addSubview(ratingLabel)
        cardView.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            movieImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 14),
            movieImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 14),
            movieImageView.widthAnchor.constraint(equalToConstant: 120),
            movieImageView.heightAnchor.constraint(equalToConstant: 180),
            movieImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -14),

            accentView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 18),
            accentView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            accentView.widthAnchor.constraint(equalToConstant: 4),
            accentView.heightAnchor.constraint(equalToConstant: 25),

            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: accentView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -14),

            ratingView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            ratingView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            
            ratingLabel.topAnchor.constraint(equalTo: ratingView.topAnchor, constant: 6),
            ratingLabel.bottomAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: -6),
            ratingLabel.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: 10),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: -10),

            descriptionLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 14),
            descriptionLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -14),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -14)
        ])
    }
}

// MARK: - Helper Method

extension MovieCell {
    func update(with movie: Movie) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        ratingLabel.text = "★ \(String(format: "%.1f", movie.voteAverage))"
        movieImageView.downloadImage(from: movie.posterPath)
    }
}


/*
 Because MovieCell is registered using MovieCell.self, the table view creates the cell programmatically. Therefore I set up the cell UI inside init(style:reuseIdentifier:). If the cell were coming from a storyboard or XIB, then awakeFromNib() would be appropriate.
 
 MovieCell.configure(with:) receives one Movie object for the current table row and maps the model properties to the corresponding UI elements. The cell does not choose or fetch which movie to display. The ViewController provides the correct movie, and the cell is only responsible for presenting it.

 The movie API gives me only a relative posterPath, so I combine it with TMDB's base image URL to create the complete URL. I convert that string into a URL, use URLSession to download the image data, convert the returned Data into a UIImage, and then update the UIImageView on the main thread.
 */
