//
//  FavoritesViewModelTests.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 17/12/24.
//

import XCTest
@testable import ChallengeGloboplay

class FavoritesViewModelTests : XCTestCase {
    
    var viewModel: FavoritesViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = FavoritesViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchMovies() {
        viewModel.fetchMovies { _ in
            XCTAssertEqual(self.viewModel.favorites?.count, 4 , "Favorites Not Loaded")
        }
    }
    
}
