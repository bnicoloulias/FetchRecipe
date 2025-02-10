//
//  RecipeView.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import SwiftUI

struct RecipeView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = recipeViewModel.errorDescription {
                    ErrorMessageView(icon: "xmark.octagon.fill", title: "Network Error", message: errorMessage, color: .red)
                } else if recipeViewModel.filteredRecipes.isEmpty {
                    ErrorMessageView(icon: "list.bullet.rectangle", title: "No Recipes Found", message: "Please check back later.", color: .gray)
                } else {
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
                                            .fill(recipeViewModel.selectedCuisine == cuisine ? Color.blue : Color(.secondarySystemBackground)) }
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
            }
            .navigationTitle("Recipes")
        }
    }
}

public struct DrawingConstants {
    static let verticalSpacing: CGFloat = 20
    static let cornerRadius: CGFloat = 10
    static let imageHeight: CGFloat = 200
    static let shadowRadius: CGFloat = 4
}

#Preview {
    RecipeView()
}
