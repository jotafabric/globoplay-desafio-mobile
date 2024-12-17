//
//  TabView.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Início")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Minha lista")
                }
        }
        .preferredColorScheme(.dark)
        .tint(Color.white)
    }
}
