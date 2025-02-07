//
//  MockNetworkService.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import Foundation

class MockNetworkService: NetworkServiceProtocol {
    func data<T: Decodable>(from url: URL) async throws -> T {
        guard let filePath = Bundle.main.path(forResource: "recipes", ofType: "json") else {
            throw NSError(domain: "MockNetworkService", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found"])
        }
        
        let fileUrl = URL(fileURLWithPath: filePath)
        let data = try Data(contentsOf: fileUrl)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
