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
    
    let movieTableView: UITableView = {
        let movieTable = UITableView()
        movieTable.translatesAutoresizingMaskIntoConstraints = false
        return movieTable
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
        self.title = "MovieDB"
        self.view.backgroundColor = .systemBackground
        setupUI()
        fetchMovies()
    }
    
    //MARK: - User Defined Methods
    
    func setupUI() {
        movieTableView.dataSource = self
        movieTableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        
        view.addSubview(movieTableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchMovies() {
        viewModel.fetchMoviesFromNetwork { [weak self] in
            DispatchQueue.main.async() {
                self?.movieTableView.reloadData()
            }
        }
    }
}

//MARK: - Datasource methods

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getTotalMoviesCount()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell
        cell?.configure(with: viewModel.getMovie(for: indexPath.row))
        return cell ?? UITableViewCell()
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
