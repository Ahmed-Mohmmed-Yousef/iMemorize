//
//  MemoryGame.swift
//  iMemorize
//
//  Created by Ahmed on 8/26/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: Array<Card>
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
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
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false {
            didSet {
                isFaceUp ? startUsingBounsTime() : stopUsingBounsTime()
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBounsTime()
            }
        }
        var content: CardContent
        
        
        
        
        //bouns time
        
        var bounsTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpTime = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpTime)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bounsTimeReminig: TimeInterval {
            max(0, bounsTimeLimit - faceUpTime)
        }
        
        var bounsReminig: Double {
            (bounsTimeLimit > 0 && bounsTimeReminig > 0) ? bounsTimeReminig/bounsTimeLimit : 0
        }
        
        var hasErnedBonus: Bool {
            isMatched && bounsTimeReminig > 0
        }
        
        var isConsumingBounsTime: Bool {
            isFaceUp && !isMatched && bounsTimeReminig > 0
        }
        
        private mutating func startUsingBounsTime() {
            if isConsumingBounsTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBounsTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
}
