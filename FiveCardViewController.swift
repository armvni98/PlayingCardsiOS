//
//  ViewController.swift
//  PlayingCard
//
//  Created by Ashadur Omith on 12/11/20.
//  Copyright © 2020 CUNY Lehman College. All rights reserved.
//

import UIKit

var _userTotal   = 0
var _cpTotal     = 0
var _dealpressed = 0
var _betCount    = 0
var _userCash    = 100
var _hasSwiped   = false

var cards2 = [PlayingCard]()

class FiveCardViewController: UIViewController {
    
    var deck2 = PlayingCardDeck()

    @IBOutlet var userCards: [PlayingCardView]!
    @IBOutlet var cpCards: [PlayingCardView]!
    
    @IBOutlet weak var userScore: UILabel!
    
    @IBOutlet weak var cpScore: UILabel!
    @IBOutlet weak var _userCashLabel: UILabel!
    
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var betButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
     @IBOutlet weak var betLabel: UILabel!
    @IBAction func betAction(_ sender: UIButton) {
        
        
        _betCount += 1
        betLabel.text = "Bet: \(_betCount)"
        
        if _betCount > 0{
            dealButton.isHidden = false
        }
    }
    
      
     @IBAction func deal(_ sender: UIButton) {
        
        
        if _dealpressed == 0{
            
            //initially selects first 3 cards2 of game
            
            betButton.isHidden = false
            
            tableCards2.append(cards2[0])
            tableCards2.append(cards2[1])
            tableCards2.append(cards2[2])
            
            tableCards2.append(cards2[3])
            tableCards2.append(cards2[4])
            
            
            
        
            
            _userTotal = tableCards2[0].cardScore + tableCards2[1].cardScore + tableCards2[2].cardScore + tableCards2[3].cardScore + tableCards2[4].cardScore
            userScore.text = "User Score: \(_userTotal)"
            
            dealButton.isHidden = true
            
            
            for view in userCards{         //for all three user cards2 face up
                view.turnFaceUp(animated: true)
                
                if let card = deck2.draw2() {
                view.rank = card.rank.order
                view.suit = card.suit.rawValue
                    
                }

            }
        }
        
        
        else if (_betCount > 0 && _cpTotal == 0 ){
            
            dealButton.isHidden = false
            betButton.isHidden = true
            
            cpTableCards2.append(cards2[0])
            cpTableCards2.append(cards2[1])
            
            
            cpTableCards2.append(cards2[2])
            
            cpTableCards2.append(cards2[3])
            cpTableCards2.append(cards2[4])
            
        
        
                    for view in cpCards{          //for all three comp cards2 face up
                        view.turnFaceUp(animated: true)
        
                        if let card = deck2.draw2() {
                        view.rank = card.rank.order
                        view.suit = card.suit.rawValue
        
                        }
        
                    }
            
            
            
            
            _cpTotal = cpTableCards2[0].cardScore + cpTableCards2[1].cardScore + cpTableCards2[2].cardScore + cpTableCards2[3].cardScore + cpTableCards2[4].cardScore
            cpScore.text = "Comp Score: \(_cpTotal)"
        
            
            
            
            if _userTotal > _cpTotal {
                _userCash += _betCount
            }
            else {
                _userCash -= _betCount
    
            }
            
            _userCashLabel.text = "$\(_userCash)"
        }
        
        
        else if (_betCount > 0 && _cpTotal > 0){
            
            

            
            for view in userCards{         //for all three user cards2 face up
                view.turnFaceDown(animated: true)
                
//                if let card = deck2.draw2() {
//                view.rank = card.rank.order
//                view.suit = card.suit.rawValue
//
//                }
                
            }
            
            for view in cpCards{         //for all three user cards2 face up
                view.turnFaceDown(animated: true)
                
//                if let card = deck2.draw2() {
//                view.rank = card.rank.order
//                view.suit = card.suit.rawValue
//
//                }
                
            }
            _dealpressed = -1
            _betCount = 0
            betLabel.text = "Bet: 0"
            
            _userTotal = 0
            _cpTotal = 0
            

            
            
            tableCards2.removeAll()

            cpTableCards2.removeAll()
            
            userScore.text = "User Score: 0"
            cpScore.text = "Comp Score: 0"
        }
        

        if cards2.count == 2 {
            dealButton.isHidden = true
        }
        _dealpressed += 1
        _hasSwiped    = false
       
        
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        cards2.removeAll()
        for suit in PlayingCard.Suit.all {
            
            for rank in PlayingCard.Rank.all {
                
                cards2.append(PlayingCard(suit: suit, rank: rank))
                
            }
            
            cards2.shuffle()
            i += 1
            
        }
      //  print(cards2.count)
        tableCards2.removeAll()
        cpTableCards2.removeAll()
        
        betButton.isHidden = true
        
         _userTotal   = 0
         _cpTotal     = 0
         _dealpressed = 0
         _betCount    = 0
         _userCash    = 100
         
        //deck2 = PlayingCardDeck()
        _userCashLabel.text = "$100"
        betLabel.text = "Bet: 0"
        userScore.text = "User Score: 0"
        cpScore.text = "Comp Score: 0"
        dealButton.isHidden = false
        
        
        for view in userCards{          //for all three user cards2
            if view.isFaceUp{
            view.turnFaceDown(animated: true)
            }
            
        }
        
        for view in cpCards{          //for all three user cards2
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
        
        if _dealpressed == 1 && !_hasSwiped{
        if let card = deck2.draw2() {

            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
            playingCardView.turnFaceDown(animated: true)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false){ _ in
                self.playingCardView.turnFaceUp(animated: true)
            }
            
                tableCards2[0] = card
                
           
            _userTotal = tableCards2[0].cardScore + tableCards2[1].cardScore + tableCards2[2].cardScore + tableCards2[3].cardScore + tableCards2[4].cardScore
            userScore.text = "User Score: \(_userTotal)"
            
            _betCount += 5
            betLabel.text = "Bet: \(_betCount)"
            

            

        }
        }
            _hasSwiped = true
    }
    
    

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
        
        if _dealpressed == 1 && !_hasSwiped{
        if let card = deck2.draw2() {

            playingCardView2.rank = card.rank.order
            playingCardView2.suit = card.suit.rawValue
            playingCardView2.turnFaceDown(animated: true)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false){ _ in
                self.playingCardView2.turnFaceUp(animated: true)
            }
            
            
            tableCards2[1] = card
            
            
            
            _userTotal = tableCards2[0].cardScore + tableCards2[1].cardScore + tableCards2[2].cardScore + tableCards2[3].cardScore + tableCards2[4].cardScore
            userScore.text = "User Score: \(_userTotal)"

            _betCount += 5
            betLabel.text = "Bet: \(_betCount)"

        }
        }
            _hasSwiped = true
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
        if _dealpressed == 1 && !_hasSwiped{
        if let card = deck2.draw2() {

            playingCardView3.rank = card.rank.order
            playingCardView3.suit = card.suit.rawValue
            
            playingCardView3.turnFaceDown(animated: true)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false){ _ in
                self.playingCardView3.turnFaceUp(animated: true)
            }
            tableCards2[2] = card
            
            
            _userTotal = tableCards2[0].cardScore + tableCards2[1].cardScore + tableCards2[2].cardScore + tableCards2[3].cardScore + tableCards2[4].cardScore
            userScore.text = "User Score: \(_userTotal)"
           
            _betCount += 5
            betLabel.text = "Bet: \(_betCount)"
            

            

        }
        }
            _hasSwiped = true
    }
    //...............thirdCard................................................
    
    
    
    //...............fourthCard................................................
    
    @IBOutlet weak var playingCardView4: PlayingCardView!{
        didSet {
            let swipe4 = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(nextCard4))
            swipe4.direction = [.right]
            playingCardView4.addGestureRecognizer(swipe4)
        }
    }
    
    @objc func nextCard4() {
        
        if _dealpressed == 1 && !_hasSwiped{
        if let card = deck2.draw2() {

            playingCardView4.rank = card.rank.order
            playingCardView4.suit = card.suit.rawValue
            playingCardView4.turnFaceDown(animated: true)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false){ _ in
                self.playingCardView4.turnFaceUp(animated: true)
            }
            
            
            
            tableCards2[3] = card
            
            
            _userTotal = tableCards2[0].cardScore + tableCards2[1].cardScore + tableCards2[2].cardScore + tableCards2[3].cardScore + tableCards2[4].cardScore
            userScore.text = "User Score: \(_userTotal)"
            
            _betCount += 5
            betLabel.text = "Bet: \(_betCount)"
            
            
            
            
            
        }
    }
        _hasSwiped = true
    }
    //...............fourthCard................................................

    
    
    
    
    //...............FifthCard................................................
    
    
    @IBOutlet weak var playingCardView5: PlayingCardView!{
        didSet {
            let swipe5 = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(nextCard5))
            swipe5.direction = [.right]
            playingCardView5.addGestureRecognizer(swipe5)
        }
    }
    
    @objc func nextCard5() {
        if _dealpressed == 1 && !_hasSwiped{
            if let card = deck2.draw2() {

            playingCardView5.rank = card.rank.order
            playingCardView5.suit = card.suit.rawValue
            playingCardView5.turnFaceDown(animated: true)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false){ _ in
                self.playingCardView5.turnFaceUp(animated: true)
            
            }
            tableCards2[4] = card
            
            
            
            _userTotal = tableCards2[0].cardScore + tableCards2[1].cardScore + tableCards2[2].cardScore + tableCards2[3].cardScore + tableCards2[4].cardScore
            userScore.text = "User Score: \(_userTotal)"
                
                _betCount += 5
                betLabel.text = "Bet: \(_betCount)"
                

                

            }
            }
                _hasSwiped = true
        }
    
    //...............FifthCard................................................
    
    
    
    
    


    

    
    @IBOutlet weak var cpFirstCardView: PlayingCardView!
    @IBOutlet weak var cpSecondCardView: PlayingCardView!
    @IBOutlet weak var cpThirdCardView: PlayingCardView!
    @IBOutlet weak var cpFourthCardView: PlayingCardView!
    @IBOutlet weak var cpFifthCardView: PlayingCardView!
    

    
    
    
    
    
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


