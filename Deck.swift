//
//  Deck.swift
//  Blackjack
//
//  Created by Jaclyn May on 9/15/14.
//  Copyright (c) 2014 iOSProgramming. All rights reserved.
//

import Foundation
/**
*  Represents a 52 card deck of Card objects
*/
class Deck{
    /// An array of Card objects
    var deck:[Card] = []
    
    init(){
        
        //Each card value is represented as a number 2 to 14. 11 to 14 represent J,Q,K,A respectively
        for i in 2...14{
            // There are four of each card value in the deck
            for x in 0...3{
                self.deck.append(Card(cardInitialVal: i));
            }
        }
    }
    
    /**
    Shuffles the 52 card deck
    Got this function from http://www.jigneshsheth.com/2014/06/card-shuffle-in-swift.html
    :returns: an array of Card objects in random order
    */
    func shuffleDeck() -> [Card] {
        var cnt = deck.count
        for i in 0..<cnt{
            var randomValue = Int(arc4random_uniform(UInt32(cnt-i))) + i
            var temporary = deck[i]
            deck[i] = deck[randomValue]
            deck[randomValue] = temporary
        }
        return deck
    }
    
}