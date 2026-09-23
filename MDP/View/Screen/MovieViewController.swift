//
//  ViewController.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/15/26.
//

import UIKit

class MovieViewController: UIViewController {
    
    //MARK: - Properties
    
    //let viewModel = MovieViewModel(objNetwork: NetworkManager.shared)
    let viewModel: MovieViewModelProtocol
    
    let searchBarField: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = Constants.searchLabel.rawValue
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .systemIndigo
        searchBar.searchTextField.backgroundColor = .systemBackground
        searchBar.searchTextField.layer.cornerRadius = 14
        searchBar.searchTextField.clipsToBounds = true
        return searchBar
    }()
    
    let movieTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 220
        return tableView
    }()
    
    let progressView: UIActivityIndicatorView = {
        let progressView = UIActivityIndicatorView(style: .large)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.hidesWhenStopped = true
        progressView.backgroundColor = .systemRed
        progressView.tintColor = .systemGray5
        return progressView
    }()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemBlue
        return refreshControl
    }()
    
    //MARK: - Initializer
    
    init(viewModel: MovieViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Life cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.moviesDBTitle.rawValue
        self.view.backgroundColor = .systemBackground
        movieTable.isScrollEnabled = true
        movieTable.alwaysBounceVertical = true
        setupUI()
        fetchMovies()
    }
    
    //MARK: - User Defined Methods
    
    func setupUI() {
        searchBarField.delegate = self
        view.addSubview(searchBarField)
        
        movieTable.dataSource = self
        movieTable.delegate = self
        movieTable.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        
        movieTable.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
        
        view.addSubview(movieTable)
        view.addSubview(progressView)
        
        setupConstraints()
    }
    
    @objc func refreshMovies() {
        print("Log:: Pull to refresh triggered")
        fetchMovies()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBarField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            searchBarField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            searchBarField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            movieTable.topAnchor.constraint(equalTo: searchBarField.bottomAnchor, constant: 5),
            movieTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func fetchMovies() {
        /// Start Animating
        startLoader()
         
        Task { [weak self] in
            guard let self = self else {
                return
            }
            await self.viewModel.fetchMoviesFromNetwork()
            await MainActor.run {
                self.stopLoader()
                self.refreshControl.endRefreshing()
                if self.viewModel.isAPIThrownError() {
                    self.handleError()
                } else {
                    self.movieTable.reloadData()
                }
            }
        }
    }
    
    func handleError() {
        if viewModel.isAPIThrownError() {
            let errorMessage = viewModel.getErrorMessage()
            let alertController = UIAlertController(title: Constants.errorLabel.rawValue, message: errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: Constants.okLabel.rawValue, style: .default)
            alertController.addAction(okAction)
            present(alertController, animated: true)
        }
    }
}

//MARK: - Datasource methods

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getTotalMoviesCount()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        guard let movie = viewModel.getMovie(for: indexPath.row) else {
            return cell
        }
        cell.update(with: movie)
        return cell
    }
}

// MARK: - Delegate Methods

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedMovie = viewModel.getMovie(for: indexPath.row) else {
            return
        }
        let detailsViewModel = MovieDetailsViewModel(movie: selectedMovie)
        let movieDetailVC = MovieDetailsViewController(viewModel: detailsViewModel)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}

// MARK: - SearchBar Delegate Methods

extension MovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchMovies(with: searchText)
        movieTable.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.clearSearch()
        movieTable.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}

// MARK: - Loader

extension MovieViewController {
    func startLoader() {
        progressView.color = .systemRed
        progressView.startAnimating()
    }
    
    func stopLoader() {
        progressView.stopAnimating()
    }
}



/*
 MovieViewController creates a MovieViewModel object so the screen can ask the ViewModel to fetch movies and provide movie data for the table view. In this non-DI version, the ViewController creates the ViewModel directly.
 
Because I'm creating MovieViewController programmatically from SceneDelegate, I need a programmatic initializer and I should not rely on Main.storyboard. SceneDelegate creates the MovieViewController, wraps it in a navigation controller, and assigns it as the window's rootViewController.
 
 In the non-DI version, the ViewController creates its own ViewModel using MovieViewModel(), so the property has a value immediately. When I later use dependency injection, the ViewModel will come through the initializer, and I must initialize that stored property before calling super.init
 
 After the ViewModel finishes fetching and storing the movie data, the ViewController receives the completion callback. Since table view updates are UI operations, I switch to the main thread and call reloadData(). The table view then asks the ViewModel again for the number of rows and the movie for each row.
 
 numberOfRowsInSection tells the table view how many rows it needs. The ViewController does not access the movie array directly. It asks the ViewModel for the total movie count, and the ViewModel gets that count from moviesData.results
 
 cellForRowAt is called for each row the table needs to display. I dequeue a reusable MovieCell, ask the ViewModel for the Movie corresponding to indexPath.row, pass that movie to the cell's configure method, and return the configured cell.
 
 I set movieTableView.dataSource = self so the table view knows that MovieViewController will provide the number of rows and configure each cell. Since MovieViewController conforms to UITableViewDataSource, the table can call those methods through self.
 
 I register MovieCell with the table view so the table knows which cell class to create whenever I dequeue using MovieCell.identifier.
 
 */

/*
 DI version
 
 MovieViewController no longer creates MovieViewModel directly. It only knows that it needs something conforming to MovieViewModelProtocol, and that dependency is provided through the initializer.
 */
