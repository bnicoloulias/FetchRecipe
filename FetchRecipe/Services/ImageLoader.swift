//
//  ImageLoader.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import SwiftUI
import CoreData

@MainActor
class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let url: URL
    private let context: NSManagedObjectContext
    private let networkService: NetworkServiceProtocol
    
    init(url: URL, context: NSManagedObjectContext, networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.url = url
        self.context = context
        self.networkService = networkService
    }
    
    func loadImage() async {
        let request = CachedImage.fetchRequest(for: url.absoluteString)
        do {
            if let cachedImage = try context.fetch(request).first,
               let data = cachedImage.imageData,
               let uiImage = UIImage(data: data) {
                print("loaded from cache")
                self.image = uiImage
                return
                
            }
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            let imgaeData: Data = try await networkService.image(from: url)
            if let uiImage = UIImage(data: imgaeData) {
                print("downlaoded image")
                self.image = uiImage
                
                await context.perform {
                    let cachedImage = CachedImage(context: self.context)
                    cachedImage.url = self.url.absoluteString
                    cachedImage.imageData = imgaeData
                    do {
                        try self.context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

// https://developer.apple.com/documentation/coredata/nsfetchrequest
extension CachedImage {
    static func fetchRequest(for urlString: String) -> NSFetchRequest<CachedImage> {
        let request = NSFetchRequest<CachedImage>(entityName: "CachedImage")
        request.predicate = NSPredicate(format: "url == %@", urlString)
        request.fetchLimit = 1
        return request
    }
}
