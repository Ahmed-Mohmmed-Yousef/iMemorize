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
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(self.card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill() 
                }
            }
        }
        .font(.system(size: fontSize(for: size)))
    }
    
    
    func fontSize(for size: CGSize) -> CGFloat { min(size.width, size.height) *  0.75 }
    
    //MARK:- Drawing constants
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojeMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
