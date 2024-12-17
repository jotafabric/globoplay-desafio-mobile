//
//  MovieCard.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//

import SwiftUI

public struct ImageCard: View {
    let backdropURL: URL
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 220)
                    .clipped()
            } placeholder: {
                Rectangle().fill(.gray)
                    .frame(width: 170, height: 220)
            }
        }
        .frame(width: 170, height: 220)
        .shadow(radius: 5)
    }
}
