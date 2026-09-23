//
//  MDPTests.swift
//  MDPTests
//
//  Created by Laasya Priya vemuri on 9/15/26.
//

/*import Testing
@testable import MDP

struct MDPTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        // Swift Testing Documentation
        // https://developer.apple.com/documentation/testing
    }
}*/

import XCTest
@testable import MDP

final class MDPTests: XCTestCase {
    var objCalculator: Calculator?
    
    var movieViewModel: MovieViewModelProtocol?
    
    override func setUpWithError() throws {
        objCalculator = Calculator()
        movieViewModel = MockMovieViewModel()
    }
    
    override func tearDownWithError() throws {
        objCalculator = nil
        movieViewModel = nil
    }
    
    func testSum() {
        let sum = objCalculator?.sumOfNums(num1: 6, num2: 2)
        XCTAssertEqual(sum, 8)
    
        let sum1 = objCalculator?.sumOfNums(num1: nil, num2: 2)
        XCTAssertEqual(sum1, 0)
        
        let sum2 = objCalculator?.sumOfNums(num1: 5, num2: nil)
        XCTAssertEqual(sum2, 0)
        
        let sum3 = objCalculator?.sumOfNums(num1: nil, num2: nil)
        XCTAssertEqual(sum3, 0)
        
        let sum4 = objCalculator?.sumOfNums(num1: 0, num2: 0)
        XCTAssertEqual(sum4, 0)
    }
    
    func testSubtraction() {
        let sub1 = objCalculator?.subtractionOfNums(num1: 4, num2: 2)
        XCTAssertEqual(sub1, 2)
        
        let sub2 = objCalculator?.subtractionOfNums(num1: 4, num2: 7)
        XCTAssertEqual(sub2, -3)
        
        let sub3 = objCalculator?.subtractionOfNums(num1: 5, num2: nil)
        XCTAssertEqual(sub3, 0)
        
        let sub4 = objCalculator?.subtractionOfNums(num1: nil, num2: 9)
        XCTAssertEqual(sub4, 0)
        
        let sub5 = objCalculator?.subtractionOfNums(num1: nil, num2: nil)
        XCTAssertEqual(sub5, 0)
    }
    
    func testMultiplication() {
        let mul1 = objCalculator?.multiplicationOfNums(num1: 5, num2: 10)
        XCTAssertEqual(mul1, 50)
        
        let mul2 = objCalculator?.multiplicationOfNums(num1: 15, num2: nil)
        XCTAssertEqual(mul2, 0)
        
        let mul3 = objCalculator?.multiplicationOfNums(num1: nil, num2: 3)
        XCTAssertEqual(mul3, 0)
        
        let mul4 = objCalculator?.multiplicationOfNums(num1: nil, num2: nil)
        XCTAssertEqual(mul4, 0)
    }
    
    func testDivison() {
        let div1 = objCalculator?.divisonOfNums(num1: 15, num2: 3)
        XCTAssertEqual(div1, 5)
        
        let div2 = objCalculator?.divisonOfNums(num1: 15, num2: nil)
        XCTAssertEqual(div2, 0)
        
        let div3 = objCalculator?.divisonOfNums(num1: nil, num2: 3)
        XCTAssertEqual(div3, 0)
        
        let div4 = objCalculator?.divisonOfNums(num1: nil, num2: nil)
        XCTAssertEqual(div4, 0)
        
        let div5 = objCalculator?.divisonOfNums(num1: 3, num2: 0)
        XCTAssertEqual(div5, 0)
    }
    
    func testGetTotalMoviesCount() {
        let moviesCount = movieViewModel?.getTotalMoviesCount()
        XCTAssertEqual(moviesCount, 0)
    }
    
    func testGetMovie() {
        let movies = movieViewModel?.getMovie(for: 0)
        XCTAssertNil(movies)
    }
    
    func testFetchMovies() {
        movieViewModel?.fetchMoviesFromNetwork { }
        XCTAssertTrue(movieViewModel?.getTotalMoviesCount() ?? 0 > 0)
    }
    
    
}
