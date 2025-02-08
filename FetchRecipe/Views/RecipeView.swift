//
//  RecipeView.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import SwiftUI
import CoreData

struct RecipeView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(recipeViewModel.cuisines, id: \.self) { cuisine in
                            Button {
                                recipeViewModel.selectedCuisine = cuisine
                            } label: {
                                Text(cuisine)
                                    .font(.subheadline)
                                    .fontWeight(recipeViewModel.selectedCuisine == cuisine ? .bold : .regular)
                                    .foregroundColor(recipeViewModel.selectedCuisine == cuisine ? .white : .black)
                                    .padding()
                                    .background(alignment: .center) {                                         RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                                        .fill(recipeViewModel.selectedCuisine == cuisine ? Color.blue : Color(.systemGray5)) }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                ScrollView {
                    LazyVStack(spacing: DrawingConstants.verticalSpacing) {
                        ForEach(recipeViewModel.filteredRecipes) { recipe in
                            RecipeCardView(recipe: recipe, context: viewContext)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
                .refreshable {
                    await recipeViewModel.refresh()
                }
            }
            .navigationTitle("Recipes")
        }
    }
}

struct RecipeCardView: View {
    let recipe: Recipe
    let context: NSManagedObjectContext
    
    var body: some View {
        VStack(alignment: .leading) {
            if let urlString = recipe.photoUrlLarge, let url = URL(string: urlString) {
                AsyncImageView(url: url, context: context)
                    .scaledToFill()
                    .frame(height: DrawingConstants.imageHeight)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius))
            }
            
            HStack {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius))
        .shadow(radius: DrawingConstants.shadowRadius)
    }
}

private struct DrawingConstants {
    static let verticalSpacing: CGFloat = 20
    static let cornerRadius: CGFloat = 10
    static let imageHeight: CGFloat = 200
    static let shadowRadius: CGFloat = 4
}

#Preview {
    RecipeView()
}
