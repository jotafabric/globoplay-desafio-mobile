//
//  DetailsViewModelTests.swift
//  ChallengeGloboplay
//
//  Created by Josias Fabrício on 17/12/24.
//

import XCTest
@testable import ChallengeGloboplay

class DetailsViewModelTests : XCTestCase {
    
    var viewModel: DetailsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = DetailsViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetMovie() {
        viewModel.getMovie(from: 533535) { _ in
            XCTAssertEqual(self.viewModel.movieDetails?.id, 533535 , "Movie Not Loaded")
        }
    }
}
