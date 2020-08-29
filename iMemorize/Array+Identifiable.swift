//
//  Array+Identifiable.swift
//  iMemorize
//
//  Created by Ahmed on 8/29/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
