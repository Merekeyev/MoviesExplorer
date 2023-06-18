//
//  MoviesFactory.swift
//  Movies Explorer
//
//  Created by Temirlan on 17.06.2023.
//

import Foundation

protocol MoviesFactoryInterface: AnyObject {
    func getMovieDetails(id: Int) -> MovieDetailViewController
}

class MoviesFactory: MoviesFactoryInterface {
    private let network = Network()
    
    static let shared = MoviesFactory()
    
    func getMovieDetails(id: Int) -> MovieDetailViewController {
        let dataSource = MovieDetailRemoteDataSource(network: network)
        let repository = MovieDetailRepository(dataSource: dataSource)
        let viewModel = MovieDetailViewModel(id: id, repository: repository)
        return MovieDetailViewController(viewModel: viewModel)
    }
}
