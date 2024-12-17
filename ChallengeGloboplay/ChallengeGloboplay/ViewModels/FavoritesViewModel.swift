//
//  FavoritesViewModel.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 16/12/24.
//

import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Movie]?
}
