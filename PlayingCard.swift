//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Ashadur Omith on 12/11/20.
//  Copyright © 2020 CUNY Lehman College. All rights reserved.
//

import Foundation


struct PlayingCard: CustomStringConvertible {
    
    var cardScore: Int {                  // cardScore evaluation
        return suit.SuitValue + rank.order
    }

    var description: String {
        return "\(rank)\(suit)"
    }
    
    
    var suit: Suit
    var rank: Rank

    
    enum Suit: String, CustomStringConvertible {
        case clubs    = "♣️"  //1
        case diamonds = "♦️"  //2
        case hearts   = "❤️"  //3
        case spades   = "♠️"  //4
        
        
        var SuitValue: Int {                //value of each suit
            switch self {
            case .clubs:    return 1
            case .diamonds: return 2
            case .hearts:   return 3
            case .spades:   return 4
            }
        }
        
        var description: String {
            return self.rawValue
        }
        
        static var all = [Suit.spades, Suit.hearts, Suit.diamonds, Suit.clubs]
    }
    
    enum Rank: CustomStringConvertible {
        case ace
        case numeric(Int)
        case face(String)
        
        var description: String {
            switch self {
            case .ace: return "A"
            case .numeric(let pips): return (String(pips))
            case .face(let kind): return kind
            }
        }
        
        var order: Int {
            switch self {
            case .ace: return 14
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(.numeric(pips))
            }
            allRanks += [.face("J"), .face("Q"), .face("K")]
            
            return allRanks
        }

    }
    
    
}
