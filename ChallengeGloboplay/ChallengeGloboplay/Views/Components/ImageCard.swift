//
//  MovieCard.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//

import SwiftUI

public struct ImageCard: View {
    let backdropURL: URL
    let width: CGFloat
    let height: CGFloat
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
            } placeholder: {
                Rectangle().fill(.gray)
                    .frame(width: width, height: height)
            }
        }
        .frame(width: width, height: height)
        .shadow(radius: 5)
    }
}
