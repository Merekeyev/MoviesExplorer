//
//  CategoryMoviesViewModel.swift
//  Movies Explorer
//
//  Created by Temirlan on 10.06.2023.
//

import Foundation

class CategoryMoviesViewModel {
    private let repository: MoviesByCategoryRepositoryInterface
    private let moviesCategory: MoviesCategory
    private(set) var movies: [MoviePosterModel] = []
    
    private(set) var state: State = .loading {
        didSet {
            DispatchQueue.main.async {
                self.didStateChange?()
            }
        }
    }
    
    var navigationTitle: String {
        moviesCategory.title
    }
    
    var didStateChange: (() -> Void)?
    var didGetError: ((String) -> Void)?
    
    enum State {
        case loading
        case content
    }

    
    init(moviesCategory: MoviesCategory, repository: MoviesByCategoryRepositoryInterface) {
        self.moviesCategory = moviesCategory
        self.repository = repository
    }
    
    func getMovies() {
        state = .loading
        movies = []

        repository.getMovies(by: moviesCategory, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movies = movies
                self.state = .content
            case .failure(let error):
                DispatchQueue.main.async {
                    self.didGetError?(error.localizedDescription)
                }
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
                DispatchQueue.main.async {
                    self.didGetError?(error.localizedDescription)
                }
            }
        })
    }
    
    func getNumberOfItemsIn(section: Int) -> Int {
        switch state {
        case .loading:
            return 6
        case .content:
            return movies.count
        }
    }
}
