//
//  ErrorMessageView.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/9/25.
//

import SwiftUI

struct ErrorMessageView: View {
    let icon: String
    let title: String
    let message: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.largeTitle)
            
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(message)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(DrawingConstants.cornerRadius)
        .padding()
    }
}
