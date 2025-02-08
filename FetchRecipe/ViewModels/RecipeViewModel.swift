//
//  RecipeViewModel.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = MockNetworkService()) {
        self.networkService = networkService
    }
    
    func fetchRecipes() async {
        do {
            let recipeResponse: RecipeResponse = try await networkService.data(from: URL(string: "recipes")!)
            self.recipes = recipeResponse.recipes
        } catch {
            print(error.localizedDescription)
        }
    }
}
