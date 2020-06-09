//
//  Store.swift
//  PotterKata
//
//  Created by Valentin Kalchev (Zuant) on 09/06/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

class Store {
    // 8 euro per book
    static let pricePerBook = 8.0
    
    // MARK: - Public
    
    func priceForBooks(_ books: [Book]) -> Double {
        var maxBundleSize = Book.Title.allCases.count
         
        // We have more books than the max bundle size - need to check whether a combination of bundle sizes will be cheaper
        if books.count > maxBundleSize {
            var price: Double = 0.0
            while maxBundleSize > 0 {
                if price == 0 {
                    price = priceForBooks(books, withMaxBundleSize: maxBundleSize)
                } else {
                    price = min(price, priceForBooks(books, withMaxBundleSize: maxBundleSize))
                }
                
                maxBundleSize -= 1
            }
            return price
            
        } else {
            return priceForBooks(books, withMaxBundleSize: maxBundleSize)
        }
    }
    
    private func priceForBooks(_ books: [Book], withMaxBundleSize size: Int) -> Double {
        let bundles = bundlesWithUniqueBooks(books, maxBundleSize: size)
        let price = priceForBundlesWithUniqueBooks(bundles)
        
        return price
    }
    
    // MARK: - Private
    
    private func bundlesWithUniqueBooks(_ books: [Book], maxBundleSize: Int) -> [Bundle] {
        var bundles: [Bundle] = []
        
        for book in books {
            if bundles.isEmpty {
                // No bundles - create one with the book
                bundles.append(Bundle(books: [book]))
            } else {
                findBundleWithoutThisBook(book, bundles: &bundles, maxBundleSize: maxBundleSize)
            }
        }
        
        return bundles
    }
    
    private func findBundleWithoutThisBook(_ book: Book, bundles: inout [Bundle], maxBundleSize: Int) {
        for index in 0..<bundles.count {
            let bundle = bundles[index]
            
            if bundle.books.count >= maxBundleSize {
                continue
                
            } else {
                if !bundle.containsBookWithTitle(book.title) {
                    // Add book to existing bundle
                    bundles[index] = Bundle(books: bundle.books + [book])
                    return
                }
            }
        }
        
        bundles.append(Bundle(books: [book]))
    }
    
    private func priceForBundlesWithUniqueBooks(_ bundles: [Bundle]) -> Double {
        return bundles.map({priceForBundleWithUniqueBooks($0)}).reduce(0, +)
    }
    
    private func priceForBundleWithUniqueBooks(_ bundle: Bundle) -> Double {
        let count = bundle.books.count
        let originalPrice = Double(count) * Store.pricePerBook
        return originalPrice - (originalPrice * discountForNumberOfUniqueBooks(count))
    }
    
    private func discountForNumberOfUniqueBooks(_ count: Int) -> Double {
        switch count {
            // 5%
            case 2: return 0.05
            
            // 10%
            case 3: return 0.1
            
            // 20%
            case 4: return 0.2
            
            // 25%
            case 5: return 0.25
            
            // No discount
            default: return 0
        }
    }
}
