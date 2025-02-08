//
//  RecipeViewModel.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    private var recipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var cuisines: [String] = []
    @Published private var _selectedCuisine: String? = nil
    var selectedCuisine: String? {
        get { _selectedCuisine }
        set {
            if _selectedCuisine == newValue {
                _selectedCuisine = nil
            } else {
                _selectedCuisine = newValue
            }
            filterRecipesByCuisine()
        }
    }
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = MockNetworkService()) {
        self.networkService = networkService
    }
    
    func fetchRecipes() async {
        do {
            let recipeResponse: RecipeResponse = try await networkService.data(from: URL(string: "recipes")!)
            //let recipeResponse: RecipeResponse = try await networkService.data(from: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!)
            self.recipes = recipeResponse.recipes.sorted { $0.name < $1.name }
            self.cuisines = Array(Set(recipes.map { $0.cuisine })).sorted()
            self.filteredRecipes = self.recipes
            self.selectedCuisine = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func filterRecipesByCuisine() {
        if let selectedCuisine = selectedCuisine {
            filteredRecipes = recipes.filter { $0.cuisine == selectedCuisine }
        } else {
            filteredRecipes = recipes
        }
    }
    
    func refresh() async {
        await fetchRecipes()
    }
}
