//
//  EmojeMemoryGameView.swift
//  iMemorize
//
//  Created by Ahmed on 8/25/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import SwiftUI

struct EmojeMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        Grid(viewModel.cards){ card in
            CardView(card: card)
                .onTapGesture { self.viewModel.choose(card: card)}
                .padding(4)
        }
        .padding()
        .foregroundColor(.orange)
        .font(.largeTitle)
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngel: Angle.degrees(110-90))
                    .padding(5)
                    .opacity(0.4)
                Text(self.card.content)
                    .font(.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
        
    }
    
    
    func fontSize(for size: CGSize) -> CGFloat { min(size.width, size.height) *  0.7 }
    
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojeMemoryGameView(viewModel: game)
    }
}
