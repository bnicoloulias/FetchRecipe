//
//  NetworkServiceProtocol.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func image(from url: URL) async throws -> Data
    func data<T: Decodable>(from url: URL) async throws -> T
}
