//
//  FavoritesView.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                if viewModel.isLoading {
                    ProgressView("Carregando...")
                    
                } else if let movies = viewModel.favorites {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(movies) { item in
                                NavigationLink {
                                    DetailsView(movieId: item.id)
                                } label: {
                                    if let url = item.backdropURL {
                                        ImageCard(
                                            backdropURL: url,
                                            width: 100,
                                            height: 160
                                        )
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .background(Color.backgroundColor)
                    }
                    .padding(.vertical)
                    .background(Color.backgroundColor)
                } else {
                    Spacer()
                    Text("Sem resultado")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
            }
            .onAppear {
                viewModel.fetchMovies { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let favorites):
                            self.viewModel.favorites = favorites
                        case .failure(let error):
                            print("Erro: \(error.localizedDescription)")
                        }
                        self.viewModel.isLoading = false
                    }
                }
            }
            .navigationTitle("Minha lista")
        }
    }
}
