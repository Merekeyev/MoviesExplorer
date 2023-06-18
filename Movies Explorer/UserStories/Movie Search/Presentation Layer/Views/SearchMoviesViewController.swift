//
//  SearchMoviesViewController.swift
//  Movies Explorer
//
//  Created by Temirlan on 17.06.2023.
//

import UIKit

class SearchMoviesViewController: UIViewController {
    private let viewModel: SearchMoviesViewModel
    private var collectionView: UICollectionView!
    private let width = UIScreen.main.bounds.width - 32
    private var searchText: String = ""
    private let searchViewController: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()
    
    init(viewModel: SearchMoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        setupCollectionView()
        setupNavigationBar()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        collectionView.register(SearchMovieCollectionViewCell.self, forCellWithReuseIdentifier: SearchMovieCollectionViewCell.identifier)
        collectionView.register(MovieSkeletonCollectionViewCell.self, forCellWithReuseIdentifier: MovieSkeletonCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.didStateChange = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.searchController = searchViewController
        searchViewController.searchBar.delegate = self
        searchViewController.delegate = self
    }
    
    @objc
    private func getMovie() {
        viewModel.getMovie(by: searchText)
    }
    
    private func searchMovie() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(getMovie), object: nil)
        self.perform(#selector(getMovie), with: nil, afterDelay: 0.5)
    }
}

extension SearchMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.state {
        case .loading:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSkeletonCollectionViewCell.identifier, for: indexPath) as! MovieSkeletonCollectionViewCell
            return cell
        case .content:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMovieCollectionViewCell.identifier, for: indexPath) as! SearchMovieCollectionViewCell
            cell.configure(movie: viewModel.movies[indexPath.row])
            return cell
        }
    }
}

extension SearchMoviesViewController: UISearchControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard viewModel.state == .content,
              indexPath.row == viewModel.movies.count - 4 else { return }
        viewModel.getMoreMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard viewModel.state == .content else { return }
        
        let id = viewModel.movies[indexPath.row].id
        let viewController = MoviesFactory.shared.getMovieDetails(id: id)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchMoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 0 else {
            collectionView.reloadData()
            return
        }
        
        self.searchText = searchText
        searchMovie()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionView.reloadData()
    }
}

extension SearchMoviesViewController: UICollectionViewDelegate {
    
}

extension SearchMoviesViewController {
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex: Int,
                                                                        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            return self.cellLayout()
        }
        
        return layout
    }
    
    private func cellLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .absolute(((width - 16) / 2) / 0.58))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(((width - 16) / 2) / 0.58))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 6, trailing: 16)
        section.interGroupSpacing = 16
        return section
    }
}
