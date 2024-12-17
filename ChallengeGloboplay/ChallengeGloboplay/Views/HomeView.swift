//
//  HomeView.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                if viewModel.isLoading {
                    ProgressView("Carregando...")
                    
                } else if let movies = viewModel.movies {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Cinema")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(movies) { item in
                                    NavigationLink {
                                        DetailsView(movieId: item.id)
                                    } label: {
                                        if let url = item.backdropURL {
                                            ImageCard(backdropURL: url)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .background(Color.backgroundColor)
                        }
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
                        case .success(let movies):
                            self.viewModel.movies = movies
                        case .failure(let error):
                            print("Erro: \(error.localizedDescription)")
                        }
                        self.viewModel.isLoading = false
                    }
                }
            }
            .navigationTitle("globoplay")
        }
    }
}
