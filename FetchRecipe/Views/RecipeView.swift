//
//  RecipeView.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import SwiftUI

struct RecipeView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        NavigationView {
            List(recipeViewModel.recipes) { recipe in
                VStack {
                    Text(recipe.name)
                }
            }
            .refreshable {
                await recipeViewModel.fetchRecipes()
            }
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    RecipeView()
}
