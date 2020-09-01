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
        VStack {
            Grid(viewModel.cards){ card in
                CardView(card: card)
                    .onTapGesture {
                        withAnimation(.linear){
                            self.viewModel.choose(card: card)
                        }
                        
                }
                .padding(4)
            }
            .padding()
            .foregroundColor(.orange)
            .font(.largeTitle)
            
            Button("New game") {
                withAnimation(.easeInOut) {
                    self.viewModel.resetGame()
                }
            }
        }
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBounsremaining: Double = 0
    
    private func startBounsTimeAnimating() {
        animatedBounsremaining = card.bounsReminig
        withAnimation(.linear(duration: card.bounsTimeReminig)) {
            animatedBounsremaining = 0
        }
    }
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBounsTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngel: Angle.degrees(-animatedBounsremaining*360-90))
                            
                            .onAppear {
                                self.startBounsTimeAnimating()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngel: Angle.degrees(-card.bounsReminig*360-90))
                    }
                }
                .padding(5).opacity(0.4)
                .transition(.identity)
                Text(self.card.content)
                    .font(.system(size: fontSize(for: size)))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1.0).repeatForever(autoreverses: false) : .none)
                
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
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
