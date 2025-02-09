//
//  RecipeCardView.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/9/25.
//

import SwiftUI
import CoreData

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
