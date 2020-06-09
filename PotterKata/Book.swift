//
//  Book.swift
//  PotterKata
//
//  Created by Valentin Kalchev (Zuant) on 09/06/20.
//  Copyright © 2020 Valentin Kalchev. All rights reserved.
//

import Foundation
 
struct Book {
    enum Title: CaseIterable {
        case A, B, C, D, E
    }
    
    let title: Title
}
