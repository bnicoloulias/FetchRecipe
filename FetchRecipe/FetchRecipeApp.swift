//
//  FetchRecipeApp.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import SwiftUI

@main
struct FetchRecipeApp: App {
    @StateObject private var recipeViewModel: RecipeViewModel = RecipeViewModel()
    let storageProvider = StorageProvider()

    var body: some Scene {
        WindowGroup {
            RecipeView()
                .task {
                    await recipeViewModel.fetchRecipes()
                }
                .environmentObject(recipeViewModel)
                .environment(
                    \.managedObjectContext,
                     storageProvider.container.viewContext
                )
        }
    }
}
