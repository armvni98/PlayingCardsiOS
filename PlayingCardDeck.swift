//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by Ashadur Omith on 12/11/20.
//  Copyright © 2020 CUNY Lehman College. All rights reserved.
//

import Foundation


var i = 0

struct PlayingCardDeck {
    
    // var cards = [PlayingCard]()
    

    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
        
            return cards.remove(at: 0)
        } else {
            return nil
        }
    }
    
    mutating func draw2() -> PlayingCard? {
        if cards2.count > 0 {
        
            return cards2.remove(at: 0)
        } else {
            return nil
        }
    }
    

    
    init() {
        while (i < 4){
        for suit in PlayingCard.Suit.all {
            
            for rank in PlayingCard.Rank.all {
                
                cards.append(PlayingCard(suit: suit, rank: rank))
                cards2.append(PlayingCard(suit: suit, rank: rank))
            }
            
            cards.shuffle()
            cards2.shuffle()
            i += 1
            
        }
        }
//        print(cards)
    }
}

extension Int {
    var arc4random: Int {
        if (self > 0) {
            return Int(arc4random_uniform(UInt32(self)))
        } else if (self < 0) {
            return -Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
    }
}

