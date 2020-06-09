//
//  Bundle.swift
//  PotterKata
//
//  Created by Valentin Kalchev (Zuant) on 09/06/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation

struct Bundle {
    let books: [Book]
    
    func containsBookWithTitle(_ title: Book.Title) -> Bool {
        return books.contains { (book) -> Bool in
            book.title == title
        }
    }
}
