//
//  SplashView.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            AppTabView()
        } else {
            ZStack {
                Image("splash")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
