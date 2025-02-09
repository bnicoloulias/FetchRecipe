//
//  FetchRecipeTests.swift
//  FetchRecipeTests
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import Testing
@testable import FetchRecipe

struct FetchRecipeTests {
    var recipeViewModel: RecipeViewModel!

    mutating func setup(with jsonType: JsonType) async {
        let mockNetworkService = MockNetworkService(jsonType: jsonType)
        recipeViewModel = await RecipeViewModel(networkService: mockNetworkService)
    }

    @Test mutating func testFetchRecipesJsonSuccess() async throws {
        await setup(with: .success)

        await recipeViewModel.fetchRecipes()

        await #expect(recipeViewModel.filteredRecipes.count == 63)
        await #expect(recipeViewModel.filteredRecipes.first?.name == "Apam Balik")
        await #expect(recipeViewModel.errorDescription == nil)
    }
    
    @Test mutating func testFetchRecipesJsonMalformed() async throws {
        await setup(with: .malformed)

        await recipeViewModel.fetchRecipes()

        await #expect(recipeViewModel.filteredRecipes.isEmpty)
        await #expect(recipeViewModel.errorDescription != nil)
    }
    
    @Test mutating func testFetchRecipesJsonEmpty() async throws {
        await setup(with: .empty)

        await recipeViewModel.fetchRecipes()

        await #expect(recipeViewModel.filteredRecipes.isEmpty)
        await #expect(recipeViewModel.errorDescription == nil)
    }
}
