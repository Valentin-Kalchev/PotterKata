//
//  StoreTests.swift
//  StoreTests
//
//  Created by Valentin Kalchev (Zuant) on 09/06/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import XCTest
@testable import PotterKata


class StoreTests: XCTestCase {
    
    func testPriceForZeroBooks() {
        expectPrice(0, forBooks: [])
    }
    
    func testPriceForOneBook() {
        booksWithTitles([.A, .B, .C, .D, .E]).forEach { (book) in
            expectPrice(Store.pricePerBook, forBooks: [book])
        }
    }
    
    func testPriceForTwoCopiesOfTheSameBook() {
        let twoCopiesOfTheSameBook: [[Book.Title]] = [[.A, .A], [.B, .B], [.C, .C], [.D, .D], [.E, .E]]
        
        twoCopiesOfTheSameBook.forEach { (titles) in
            let books = booksWithTitles(titles)
            let expectedPrice = Store.pricePerBook * Double(books.count)
            expectPrice(expectedPrice, forBooks: books)
        }
    }
    
    func testPriceForTwoUniqueBooks() {
        let twoUniqueBookTitles: [[Book.Title]] = [[.A, .B], [.B, .C], [.C, .D], [.D, .E]]
        twoUniqueBookTitles.forEach { (titles) in
            let books = booksWithTitles(titles)
            // 5% discount
            let expectedPrice = (Store.pricePerBook * Double(books.count)) * 0.95
            expectPrice(expectedPrice, forBooks: books)
        }
    }
    
    func testPriceForThreeUniqueBooks() {
        let threeUniqueBookTitles: [[Book.Title]] = [[.A, .B, .C], [.B, .C, .D], [.C, .D, .E], [.A, .D, .E]]
        threeUniqueBookTitles.forEach { (titles) in
            let books = booksWithTitles(titles)
            
            // 10% discount
            let expectedPrice = (Store.pricePerBook * Double(books.count)) * 0.90
            expectPrice(expectedPrice, forBooks: books)
        }
    }
    
    func testPriceForFourUniqueBooks() {
        let fourUniqueBookTitles: [[Book.Title]] = [[.A, .B, .C, .D], [.B, .C, .D, .E]]
        fourUniqueBookTitles.forEach { (titles) in
            let books = booksWithTitles(titles)
            
            // 20% discount
            let expectedPrice = (Store.pricePerBook * Double(books.count)) * 0.80
            expectPrice(expectedPrice, forBooks: books)
        }
    }

    func testPriceForOneOfEachBooks() {
        let books = booksWithTitles([.A, .B, .C, .D, .E])
        
        // 25% discount
        let expectedPrice = (Store.pricePerBook * Double(books.count)) * 0.75
        expectPrice(expectedPrice, forBooks: books)
    }
    
    func testBuy2copiesOfBookA_2copiesOfBookB_2CopiesOfBookC_1copyOfBookD_1copyOfBookE() {
        /*
             2 copies of the first book
             2 copies of the second book
             2 copies of the third book
             1 copy of the fourth book
             1 copy of the fifth book
        */
        
        let books = booksWithTitles([.A, .A, .B, .B, .C, .C, .D, .E])

//      Result - 51.6
//        let bundleOne = (Store.pricePerBook * 5) * 0.75
//        let bundleTwo = (Store.pricePerBook * 3) * 0.9

//      Result - 51.2 CHEAPER!!!
        let bundleOne = (Store.pricePerBook * 4) * 0.8
        let bundleTwo = (Store.pricePerBook * 4) * 0.8
        
        expectPrice(bundleOne + bundleTwo, forBooks: books)
    }
     
    // MARK: - Helper
    
    func booksWithTitles(_ titles: [Book.Title]) -> [Book] {
        return titles.map({Book(title: $0)})
    }
    
    func expectPrice(_ expectedPrice: Double, forBooks books: [Book], file: StaticString = #file, line: UInt = #line) {
        let sut = makeSUT()
        let price = sut.priceForBooks(books)
        XCTAssertEqual(expectedPrice, price, file: file, line: line)
    }
    
    func makeSUT() -> Store {
        return Store()
    }
}
