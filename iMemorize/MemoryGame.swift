//
//  MemoryGame.swift
//  iMemorize
//
//  Created by Ahmed on 8/26/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    mutating func choose(card: Card) {
        let indexOfCard: Int = self.index(of: card)
        self.cards[indexOfCard].isFaceUp = !self.cards[indexOfCard].isFaceUp
        print("card chosen: ", card)
    }
    
    private func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if card.id == cards[index].id {
                return index
            }
        }
        return 0
    }
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(index)
            cards.append(Card(id: index*2, content: content))
            cards.append(Card(id: index*2+1, content: content))
        }
    }
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        
    }
}
