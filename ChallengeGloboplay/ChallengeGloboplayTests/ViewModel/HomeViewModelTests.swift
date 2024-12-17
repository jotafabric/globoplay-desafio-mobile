//
//  ChallengeGloboplayTests.swift
//  ChallengeGloboplayTests
//
//  Created by Josias Fabrício on 16/12/24.
//

import XCTest
@testable import ChallengeGloboplay

class HomeViewModelTests : XCTestCase {
    
    var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchMovies() {
        viewModel.fetchMovies { _ in
            XCTAssertEqual(self.viewModel.movies?.count, 20 , "Movies Not Loaded")
        }
    }
    
    func testFetchTvSeries() {
        viewModel.fetchTvSeries { _ in
            XCTAssertEqual(self.viewModel.tvSeries?.count, 20 , "Tv Series Not Loaded")
        }
    }
    
}
