//
//  MockNetworkService.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import SwiftUI

class MockNetworkService: NetworkServiceProtocol {
    func data<T: Decodable>(from url: URL) async throws -> T {
        guard let filePath = Bundle.main.path(forResource: url.absoluteString, ofType: "json") else {
            throw NetworkServiceError.invalidURL
        }
        
        let fileUrl = URL(fileURLWithPath: filePath)
        
        do {
            let data = try Data(contentsOf: fileUrl)
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
        return (UIImage(systemName: "clock")?.pngData())!
    }
}
