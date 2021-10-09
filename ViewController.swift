//
//  ViewController.swift
//  PlayingCard
//
//  Created by Ashadur Omith on 12/11/20.
//  Copyright © 2020 CUNY Lehman College. All rights reserved.
//

import UIKit

var userTotal   = 0
var cpTotal     = 0
var dealpressed = 0
var betCount    = 0
var userCash    = 100
var hasSwiped   = false

var tableCards   = [PlayingCard]()
var cpTableCards = [PlayingCard]()

var tableCards2   = [PlayingCard]()
var cpTableCards2 = [PlayingCard]()

var cards = [PlayingCard]()

class ViewController: UIViewController {

    var deck = PlayingCardDeck()

    @IBOutlet var userCards: [PlayingCardView]!
    @IBOutlet var cpCards: [PlayingCardView]!
    
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var cpScore: UILabel!
    @IBOutlet weak var userCashLabel: UILabel!
    
    //private var cardGame = CardGame()
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var betButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    @IBOutlet weak var betLabel: UILabel!
    @IBAction func betAction(_ sender: UIButton) {
        betCount += 1
        betLabel.text = "Bet: \(betCount)"
        
        if betCount > 0 && cards.count != 1 {
            dealButton.isHidden = false
        }
        if cards.count == 1 {
            betButton.isHidden = true
        }
    }
    
    
    
    
    @IBAction func deal(_ sender: UIButton) {
        
        
        if dealpressed == 0{
            
            //initially selects first 3 cards of game
            
            betButton.isHidden = false
            
            tableCards.append(cards[0])
            tableCards.append(cards[1])
            tableCards.append(cards[2])
            
            userTotal = tableCards[0].cardScore + tableCards[1].cardScore + tableCards[2].cardScore
            userScore.text = "User Score: \(userTotal)"
            
            dealButton.isHidden = true
            
            
            for view in userCards{         //for all three user cards face up
                view.turnFaceUp(animated: true)
                
                if let card = deck.draw() {
                view.rank = card.rank.order
                view.suit = card.suit.rawValue
                    
                }

            }
        }
        
        
        else if (betCount > 0 && cpTotal == 0 ){
            
            dealButton.isHidden = false
            betButton.isHidden = true
            
            cpTableCards.append(cards[0])
            cpTableCards.append(cards[1])
            cpTableCards.append(cards[2])
            
        
        
                    for view in cpCards{          //for all three comp cards face up
                        view.turnFaceUp(animated: true)
        
                        if let card = deck.draw() {
                        view.rank = card.rank.order
                        view.suit = card.suit.rawValue
        
                        }
        
                    }
            
            
            cpTotal = cpTableCards[0].cardScore + cpTableCards[1].cardScore + cpTableCards[2].cardScore
            cpScore.text = "Comp Score: \(cpTotal)"
        
            
            
            
            if userTotal > cpTotal {
                userCash += betCount
            }
            else {
                userCash -= betCount
    
            }
            
            userCashLabel.text = "$\(userCash)"
        }
        
        
        else if (betCount > 0 && cpTotal > 0){
            
            

            
            for view in userCards{         //for all three user cards face up
                view.turnFaceDown(animated: true)
                
//                if let card = deck.draw() {
//                view.rank = card.rank.order
//                view.suit = card.suit.rawValue
//
//                }
                
            }
            
            for view in cpCards{         //for all three user cards face up
                view.turnFaceDown(animated: true)
                
//                if let card = deck.draw() {
//                view.rank = card.rank.order
//                view.suit = card.suit.rawValue
//
//                }
                
            }
            dealpressed = -1
            betCount = 0
            betLabel.text = "Bet: 0"
            
            userTotal = 0
            cpTotal = 0
            
            
            
            tableCards.remove(at: 0)
            tableCards.remove(at: 0)
            tableCards.remove(at: 0)
            
            
            cpTableCards.removeAll()
            
            userScore.text = "User Score: 0"
            cpScore.text = "Comp Score: 0"
        }
        
        if cards.count == 1 {
            dealButton.isHidden = true
        }

        dealpressed += 1
        hasSwiped = false
        
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        cards.removeAll()
        for suit in PlayingCard.Suit.all {
            
            for rank in PlayingCard.Rank.all {
                
                cards.append(PlayingCard(suit: suit, rank: rank))
                
            }
            
            cards.shuffle()
            i += 1
            
        }
        
       // print(cards.count)
        tableCards.removeAll()
        cpTableCards.removeAll()
        
        
        
        betButton.isHidden = true
         userTotal   = 0
         cpTotal     = 0
         dealpressed = 0
         betCount    = 0
         userCash    = 100
        //deck = PlayingCardDeck()
        userCashLabel.text = "$100"
        betLabel.text = "Bet: 0"
        userScore.text = "User Score: 0"
        cpScore.text = "Comp Score: 0"
        dealButton.isHidden = false
        
        
        for view in userCards{          //for all three user cards
            if view.isFaceUp{
            view.turnFaceDown(animated: true)
            }
            
        }
        
        for view in cpCards{          //for all three user cards
            if view.isFaceUp{
            view.turnFaceDown(animated: true)
            }
            
        }
    }
    
    //...............firstCard................................................
    @IBOutlet weak var playingCardView: PlayingCardView! {
        
        didSet {
            
            
            let swipe = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(nextCard))
            
            swipe.direction = [.right]
            
            playingCardView.addGestureRecognizer(swipe)
            
            
        }
        
        
    }

    @objc func nextCard() {
        
        
        if dealpressed == 1 && !hasSwiped{
        if let card = deck.draw() {

            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
            playingCardView.turnFaceDown(animated: true)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false){ _ in
                self.playingCardView.turnFaceUp(animated: true)
            }
            
                tableCards[0] = card
                
           
            userTotal = tableCards[0].cardScore + tableCards[1].cardScore + tableCards[2].cardScore
            userScore.text = "User Score: \(userTotal)"
            
            betCount += 5
            betLabel.text = "Bet: \(betCount)"

            

            

        }
    }
        hasSwiped = true
    }
    
//    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
//        switch sender.state {
//        case .ended:
//            playingCardView.isFaceUp = !playingCardView.isFaceUp
//        default:
//            break
//        }
//    }
    //...............firstCard................................................
    
    
    
    //...............secondCard................................................
    @IBOutlet weak var playingCardView2: PlayingCardView!{
        didSet {
            let swipe2 = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(nextCard2))
            swipe2.direction = [.right]
            playingCardView2.addGestureRecognizer(swipe2)
                        
        }
    }

    @objc func nextCard2() {
        if dealpressed == 1 && !hasSwiped{
        if let card = deck.draw() {

            playingCardView2.rank = card.rank.order
            playingCardView2.suit = card.suit.rawValue
            playingCardView2.turnFaceDown(animated: true)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false){ _ in
                self.playingCardView2.turnFaceUp(animated: true)
            }
            
            
            
            
            
            tableCards[1] = card
            
            
            
            userTotal = tableCards[0].cardScore + tableCards[1].cardScore + tableCards[2].cardScore
            userScore.text = "User Score: \(userTotal)"
            
            betCount += 5
            betLabel.text = "Bet: \(betCount)"

        }
        }
        hasSwiped = true
    }
    

    //...............secondCard................................................
    
    
    //...............thirdCard................................................
    @IBOutlet weak var playingCardView3: PlayingCardView!{
        didSet {
            let swipe3 = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(nextCard3))
            swipe3.direction = [.right]
            playingCardView3.addGestureRecognizer(swipe3)
        }
    }
    
    @objc func nextCard3() {
        
        if dealpressed == 1 && !hasSwiped{
        if let card = deck.draw() {

            playingCardView3.rank = card.rank.order
            playingCardView3.suit = card.suit.rawValue
            playingCardView3.turnFaceDown(animated: true)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false){ _ in
                self.playingCardView3.turnFaceUp(animated: true)
            }
            tableCards[2] = card
            
            
            //var card3 = tableCards[0].cardScore + tableCards[1].cardScore + tableCards[2].cardScore
            userTotal = tableCards[0].cardScore + tableCards[1].cardScore + tableCards[2].cardScore
            userScore.text = "User Score: \(userTotal)"
            
            betCount += 5
            betLabel.text = "Bet: \(betCount)"

        }
        }
            hasSwiped = true
    }
    

    //...............thirdCard................................................
    
    //...............CPFirstCard................................................
    
        @IBOutlet weak var cpFirstCardView: PlayingCardView!
        @IBOutlet weak var cpSecondCardView: PlayingCardView!
        @IBOutlet weak var cpThirdCardView: PlayingCardView!
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        betButton.isHidden = true
        dealButton.layer.cornerRadius = 7
        betButton.layer.cornerRadius = 7
        resetButton.layer.cornerRadius = 7
        
        betLabel.layer.cornerRadius = 7
        userScore.layer.cornerRadius = 7
        
        
    }
        
}


