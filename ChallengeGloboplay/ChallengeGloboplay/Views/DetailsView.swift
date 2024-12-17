//
//  MovieDetailView.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//

import SwiftUI

struct DetailsView: View {
    @StateObject private var viewModel = DetailsViewModel()
    let movieId: Int
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Carregando...")
            } else if let movie = viewModel.movie {
                VStack {
                    AsyncImage(url: movie.backdropURL) { image in
                        image
                            .resizable()
                            .frame(height: 450)
                            .blur(radius: 10)
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                }
                .ignoresSafeArea(edges: .top)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        if let url = movie.backdropURL {
                            ImageCard(backdropURL: url)
                        }
                        
                        Text(movie.title)
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .padding(.top, 8)
                        
                        Text(movie.overview)
                            .foregroundColor(Color.detailtColor)
                            .padding(.horizontal, 16)
                            .lineLimit(3)
                            .truncationMode(.tail)
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                //TODO
                            }) {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("Assista")
                                }
                                .padding()
                                .frame(width: 180)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                            }
                            Button(action: {
                                //TODO
                            }) {
                                HStack {
                                    Image(systemName: "star.fill")
                                    Text("Minha lista")
                                }
                                .padding()
                                .frame(width: 180)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .border(Color.tileColor, width: 3)
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        VStack(spacing: 16) {
                            HStack {
                                Text("Detalhes")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            Text(movie.overview)
                                .foregroundColor(Color.detailtColor)
                                .padding(.horizontal)
                                .fixedSize(horizontal: false, vertical: true)
                            
                        }
                        .padding()
                        .background(Color.backgroundColor)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                        
                        Spacer()
                    }
                    .padding(.top, 16)
                }
            } else {
                Spacer()
                Text("Sem resultado")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            }
        }
        .onAppear{
            viewModel.getMovie(from: movieId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let movie):
                        self.viewModel.movie = movie
                    case .failure(let error):
                        print("Erro: \(error.localizedDescription)")
                    }
                    self.viewModel.isLoading = false
                }
            }
        }
    }
}
