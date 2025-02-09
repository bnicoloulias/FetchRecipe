//
//  NetworkService.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import Foundation

enum NetworkServiceError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .networkError(let error):
            return "A network error occurred: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        }
    }
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func data<T: Decodable>(from url: URL) async throws -> T {
        do {
            let (data, response) = try await session.data(from: url)
            
            let _ = try checkResponseCode(response)
            
            return try JSONDecoder().decode(T.self, from: data)
            
        } catch let error as DecodingError {
            throw NetworkServiceError.decodingError(error)
        } catch let error as URLError {
            throw NetworkServiceError.networkError(error)
        } catch {
            throw NetworkServiceError.networkError(error)
        }
    }
    
    func image(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)
        
        let _ = try checkResponseCode(response)
        
        return data
    }
    
    private func checkResponseCode(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkServiceError.networkError(URLError(.badServerResponse))
        }
    }
}
