//
//  FavoritesView.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer()
                Text("Sem resultado")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                    .background(Color.backgroundColor)
            }
            .navigationTitle("Minha lista")
        }
    }
}
