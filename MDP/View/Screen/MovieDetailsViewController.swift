//
//  MovieDetailsViewController.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/16/26.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: MovieDetailsViewModelProtocol
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(systemName: Constants.defaultImage.rawValue)
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    let ratingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.15)
        view.layer.cornerRadius = 14
        return view
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemOrange
        return label
    }()
    
    let languageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.12)
        view.layer.cornerRadius = 14
        return view
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .systemIndigo
        return label
    }()
    
    let informationCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 18
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()
    
    let informationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.movieInfoLabel.rawValue
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemIndigo
        return label
    }()
    
    let idLabel = MovieDetailsViewController.createInfoLabel()
    let originalTitleLabel = MovieDetailsViewController.createInfoLabel()
    let releaseDateLabel = MovieDetailsViewController.createInfoLabel()
    let genresLabel = MovieDetailsViewController.createInfoLabel()
    let voteCountLabel = MovieDetailsViewController.createInfoLabel()
    let popularityLabel = MovieDetailsViewController.createInfoLabel()
    
    let statusCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 18
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()
    
    let statusTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.statusLabel.rawValue
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemIndigo
        return label
    }()
    
    let adultLabel = MovieDetailsViewController.createInfoLabel()
    let softcoreLabel = MovieDetailsViewController.createInfoLabel()
    let videoLabel = MovieDetailsViewController.createInfoLabel()
    
    let overviewCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 18
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()
    
    let overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.overviewLabel.rawValue
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .systemIndigo
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializer
    
    init(viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.movieDetailsTitle.rawValue
        view.backgroundColor = .systemGroupedBackground
        setupUI()
        configureMovieDetails()
    }
    
    // MARK: - User Defined Methods
    
    static func createInfoLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }
    
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(languageView)
        contentView.addSubview(informationCardView)
        contentView.addSubview(statusCardView)
        contentView.addSubview(overviewCardView)
        
        ratingView.addSubview(ratingLabel)
        
        languageView.addSubview(languageLabel)
        
        informationCardView.addSubview(informationTitleLabel)
        informationCardView.addSubview(idLabel)
        informationCardView.addSubview(originalTitleLabel)
        informationCardView.addSubview(releaseDateLabel)
        informationCardView.addSubview(genresLabel)
        informationCardView.addSubview(voteCountLabel)
        informationCardView.addSubview(popularityLabel)
        
        statusCardView.addSubview(statusTitleLabel)
        statusCardView.addSubview(adultLabel)
        statusCardView.addSubview(softcoreLabel)
        statusCardView.addSubview(videoLabel)
        
        overviewCardView.addSubview(overviewTitleLabel)
        overviewCardView.addSubview(overviewLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            
            contentView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor
            ),
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor
            ),
            contentView.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor
            ),
            contentView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor
            ),
            contentView.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor
            ),
            
            movieImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            movieImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            movieImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            movieImageView.heightAnchor.constraint(
                equalToConstant: 250
            ),
            
            titleLabel.topAnchor.constraint(
                equalTo: movieImageView.bottomAnchor,
                constant: 20
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),
            
            ratingView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 14
            ),
            ratingView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            
            ratingLabel.topAnchor.constraint(
                equalTo: ratingView.topAnchor,
                constant: 7
            ),
            ratingLabel.bottomAnchor.constraint(
                equalTo: ratingView.bottomAnchor,
                constant: -7
            ),
            ratingLabel.leadingAnchor.constraint(
                equalTo: ratingView.leadingAnchor,
                constant: 12
            ),
            
            ratingLabel.trailingAnchor.constraint(
                equalTo: ratingView.trailingAnchor,
                constant: -12
            ),
            
            languageView.centerYAnchor.constraint(
                equalTo: ratingView.centerYAnchor
            ),
            languageView.leadingAnchor.constraint(
                equalTo: ratingView.trailingAnchor,
                constant: 12
            ),
            
            languageLabel.topAnchor.constraint(
                equalTo: languageView.topAnchor,
                constant: 7
            ),
            languageLabel.bottomAnchor.constraint(
                equalTo: languageView.bottomAnchor,
                constant: -7
            ),
            languageLabel.leadingAnchor.constraint(
                equalTo: languageView.leadingAnchor,
                constant: 12
            ),
            languageLabel.trailingAnchor.constraint(
                equalTo: languageView.trailingAnchor,
                constant: -12
            ),
            
            informationCardView.topAnchor.constraint(
                equalTo: ratingView.bottomAnchor,
                constant: 24
            ),
            informationCardView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            informationCardView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            
            informationTitleLabel.topAnchor.constraint(
                equalTo: informationCardView.topAnchor,
                constant: 18
            ),
            informationTitleLabel.leadingAnchor.constraint(
                equalTo: informationCardView.leadingAnchor,
                constant: 18
            ),
            informationTitleLabel.trailingAnchor.constraint(
                equalTo: informationCardView.trailingAnchor,
                constant: -18
            ),
            
            idLabel.topAnchor.constraint(
                equalTo: informationTitleLabel.bottomAnchor,
                constant: 18
            ),
            idLabel.leadingAnchor.constraint(
                equalTo: informationCardView.leadingAnchor,
                constant: 18
            ),
            idLabel.trailingAnchor.constraint(
                equalTo: informationCardView.trailingAnchor,
                constant: -18
            ),
            
            originalTitleLabel.topAnchor.constraint(
                equalTo: idLabel.bottomAnchor,
                constant: 14
            ),
            originalTitleLabel.leadingAnchor.constraint(
                equalTo: idLabel.leadingAnchor
            ),
            originalTitleLabel.trailingAnchor.constraint(
                equalTo: idLabel.trailingAnchor
            ),
            
            releaseDateLabel.topAnchor.constraint(
                equalTo: originalTitleLabel.bottomAnchor,
                constant: 14
            ),
            releaseDateLabel.leadingAnchor.constraint(
                equalTo: idLabel.leadingAnchor
            ),
            releaseDateLabel.trailingAnchor.constraint(
                equalTo: idLabel.trailingAnchor
            ),
            
            genresLabel.topAnchor.constraint(
                equalTo: releaseDateLabel.bottomAnchor,
                constant: 14
            ),
            genresLabel.leadingAnchor.constraint(
                equalTo: idLabel.leadingAnchor
            ),
            genresLabel.trailingAnchor.constraint(
                equalTo: idLabel.trailingAnchor
            ),
            
            voteCountLabel.topAnchor.constraint(
                equalTo: genresLabel.bottomAnchor,
                constant: 14
            ),
            voteCountLabel.leadingAnchor.constraint(
                equalTo: idLabel.leadingAnchor
            ),
            voteCountLabel.trailingAnchor.constraint(
                equalTo: idLabel.trailingAnchor
            ),
            
            popularityLabel.topAnchor.constraint(
                equalTo: voteCountLabel.bottomAnchor,
                constant: 14
            ),
            
            popularityLabel.leadingAnchor.constraint(
                equalTo: idLabel.leadingAnchor
            ),
            popularityLabel.trailingAnchor.constraint(
                equalTo: idLabel.trailingAnchor
            ),
            popularityLabel.bottomAnchor.constraint(
                equalTo: informationCardView.bottomAnchor,
                constant: -18
            ),
            
            statusCardView.topAnchor.constraint(
                equalTo: informationCardView.bottomAnchor,
                constant: 20
            ),
            statusCardView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            statusCardView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            
            statusTitleLabel.topAnchor.constraint(
                equalTo: statusCardView.topAnchor,
                constant: 18
            ),
            statusTitleLabel.leadingAnchor.constraint(
                equalTo: statusCardView.leadingAnchor,
                constant: 18
            ),
            
            adultLabel.topAnchor.constraint(
                equalTo: statusTitleLabel.bottomAnchor,
                constant: 18
            ),
            adultLabel.leadingAnchor.constraint(
                equalTo: statusTitleLabel.leadingAnchor
            ),
            
            softcoreLabel.topAnchor.constraint(
                equalTo: adultLabel.bottomAnchor,
                constant: 14
            ),
            softcoreLabel.leadingAnchor.constraint(
                equalTo: statusTitleLabel.leadingAnchor
            ),
            
            videoLabel.topAnchor.constraint(
                equalTo: softcoreLabel.bottomAnchor,
                constant: 14
            ),
            videoLabel.leadingAnchor.constraint(
                equalTo: statusTitleLabel.leadingAnchor
            ),
            videoLabel.bottomAnchor.constraint(
                equalTo: statusCardView.bottomAnchor,
                constant: -18
            ),
            
            overviewCardView.topAnchor.constraint(
                equalTo: statusCardView.bottomAnchor,
                constant: 20
            ),
            overviewCardView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            overviewCardView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            
            overviewTitleLabel.topAnchor.constraint(
                equalTo: overviewCardView.topAnchor,
                constant: 18
            ),
            overviewTitleLabel.leadingAnchor.constraint(
                equalTo: overviewCardView.leadingAnchor,
                constant: 18
            ),
            overviewTitleLabel.trailingAnchor.constraint(
                equalTo: overviewCardView.trailingAnchor,
                constant: -18
            ),
            
            overviewLabel.topAnchor.constraint(
                equalTo: overviewTitleLabel.bottomAnchor,
                constant: 14
            ),
            overviewLabel.leadingAnchor.constraint(
                equalTo: overviewCardView.leadingAnchor,
                constant: 18
            ),
            overviewLabel.trailingAnchor.constraint(
                equalTo: overviewCardView.trailingAnchor,
                constant: -18
            ),
            overviewLabel.bottomAnchor.constraint(
                equalTo: overviewCardView.bottomAnchor,
                constant: -18
            ),
            
            overviewCardView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -30
            )
        ])
    }
    
    func configureMovieDetails() {
        movieImageView.downloadImage(from: viewModel.imagePath, size: "w780")
        titleLabel.text = viewModel.movieTitle
        ratingLabel.text = viewModel.ratingText
        languageLabel.text = viewModel.languageText
        idLabel.text = viewModel.idText
        originalTitleLabel.text = viewModel.originalTitleText
        releaseDateLabel.text = viewModel.releaseDateText
        genresLabel.text = viewModel.genresText
        voteCountLabel.text = viewModel.voteCountText
        popularityLabel.text = viewModel.popularityText
        adultLabel.text = viewModel.adultText
        softcoreLabel.text = viewModel.softcoreText
        videoLabel.text = viewModel.videoText
        overviewLabel.text = viewModel.overviewText
    }
}

