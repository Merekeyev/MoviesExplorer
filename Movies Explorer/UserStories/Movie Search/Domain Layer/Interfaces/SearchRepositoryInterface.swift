//
//  SearchRepositoryInterface.swift
//  Movies Explorer
//
//  Created by Temirlan on 17.06.2023.
//

import Foundation

protocol SearchRepositoryInterface: AnyObject {
    func getMovies(by query: String, completion: @escaping (Result<[MoviePosterModel], Error>) -> Void)
    func getMoreMovies(completion: @escaping (Result<[MoviePosterModel], Error>) -> Void)
}
