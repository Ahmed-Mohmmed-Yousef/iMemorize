//
//  EmojiMemoryGame.swift
//  iMemorize
//
//  Created by Ahmed on 8/26/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

func createCardContent(pairIndex: Int) -> String { "😁" }
class EmojiMemoryGame {
    
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { index  in emojis[index] }
    }
    
    // Access to model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK:- Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
