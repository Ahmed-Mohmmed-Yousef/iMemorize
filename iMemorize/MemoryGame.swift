//
//  MemoryGame.swift
//  iMemorize
//
//  Created by Ahmed on 8/26/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    var cards: Array<Card>
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get { return cards.indices.filter{cards[$0].isFaceUp}.only }
        set {
            for index in cards.indices { cards[index].isFaceUp = index == newValue }
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentailMatchIndex = indexOfOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentailMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentailMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
             } else {
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
        }
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
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
    }
}
