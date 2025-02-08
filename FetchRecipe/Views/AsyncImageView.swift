//
//  AsyncImageView.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import SwiftUI
import CoreData

struct AsyncImageView: View {
    @StateObject private var imageLoader: ImageLoader
    
    init(url: URL, context: NSManagedObjectContext) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url, context: context))
    }
    
    var body: some View {
        Group {
            if let uiImage = imageLoader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
        .task {
            await imageLoader.loadImage()
        }
    }
}

//#Preview {
//    AsyncImageView()
//}
