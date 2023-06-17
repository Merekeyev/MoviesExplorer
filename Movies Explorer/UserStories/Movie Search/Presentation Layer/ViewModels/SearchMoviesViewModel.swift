//
//  SearchMoviesViewModel.swift
//  Movies Explorer
//
//  Created by Temirlan on 17.06.2023.
//

import Foundation

class SearchMoviesViewModel {
    var didStateChange: (() -> Void)?
    
    private let repository: SearchRepositoryInterface
    private(set) var movies: [MoviePosterModel] = []
    private(set) var state: State = .content {
        didSet {
            DispatchQueue.main.async {
                self.didStateChange?()
            }
        }
    }
    
    var numberOfItems: Int {
        switch state {
        case .loading:
            return 4
        case .content:
            return movies.count
        }
    }
    
    enum State {
        case loading
        case content
    }
    
    init(repository: SearchRepositoryInterface) {
        self.repository = repository
    }
    
    func getMovie(by query: String) {
        self.state = .loading
        movies = []
        
        repository.getMovies(by: query, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movies = movies
                self.state = .content
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func getMoreMovies() {
        repository.getMoreMovies(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movies += movies
                self.state = .content
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
