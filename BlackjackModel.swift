//
//  BlackjackModel.swift
//  Blckjack
//
//  Created by Jaclyn May on 9/9/14.
//  Copyright (c) 2014 iOSProgramming. All rights reserved.
//

import Foundation

class BlackjackModel{
    var deck:Deck
    var player:Player
    var dealer:Dealer
    var gameNumber:Int
    var gameOverMessage:String?
    
    init(){
        self.deck = Deck()
        self.player = Player()
        self.dealer = Dealer()
        self.deck.deck = self.deck.shuffleDeck()
        self.gameNumber = 0
        self.gameOverMessage = nil
    }
    
    func newGame() {
        gameOverMessage = nil
        player.clear()
        dealer.clear()
        // TODO: Check gameNumber calculation
        if gameNumber <= 5{
            gameNumber++
            
        }else{
            gameNumber=0
            deck.deck=deck.shuffleDeck()
        }
        
    }

    
    /**
    Deal the initial cards to the player and dealer and evaluate if either has blackjack
    */
    func deal(){
        for i in 0...1{
            var card:Card = deck.deck.removeAtIndex(0)
            // Add top card in deck to player's hand
            player.addCard(card)
            // Place card at the end of the deck
            deck.deck.append(card)
            // Add next card to dealer's handƒ
            card = deck.deck.removeAtIndex(0)
            dealer.addCard(card)
            deck.deck.append(card)
        }
        var dealerHasBlackjack = false
        // dealer.dealerTotal does not include the value of the holeCard and right nowjust contains the value of the dealer's face up card
        // Dealer checks if he has blackjack if second card has a value of 10 or 11
        if dealer.dealerTotal >= 10{
            dealerHasBlackjack = dealer.hasBlackjack()
        }
        // Check whether either or both the player or dealer have blackjack
        // If both player and dealer have blackjack -> push()
        if player.hasBlackjack() && dealerHasBlackjack{
            push()
        }
        else if !player.hasBlackjack() && dealerHasBlackjack {
            playerLose()
        }
        else if player.hasBlackjack() && !dealerHasBlackjack{
            playerBj()
        }
    }
    
    func push(){
        gameOverMessage = "Shucks - it's a tie. Wanna play again? Click the New Game button and place a bet."
    }
    
    /**
    If a player has blackjack (2 cards valuing at 10 and 11) and dealer does not,
    they win 1.5 times their bet
    */
    func playerBj(){
        player.funds += player.playerBet*1.5
        gameOverMessage = "You got BLACKJACK, YEERHAW! Wanna play again? Click the New Game button and place a bet."
    }
    
    /**
    If dealer busts or player has a higher value under 21 than the dealer, the player wins the amount she put in
    */
    func playerWin(){
        player.funds += player.playerBet
        gameOverMessage = "You beat the dealer! Ride em cowgirl. Wanna play again? Click the New Game button and place a bet."
        
    }
    /**
    If the player busts, or the dealer has blackjack, or the dealer has a higher ultimate total hand under 21
    than the player, the player loses the amount that they bet
    */
    func playerLose(){
        player.funds-=player.playerBet
        gameOverMessage="I don't know how to tell you this... but you lost </3. Wanna give it another go? Click the New Game button and place a bet."
    }
    
    /**
    Player chooses to hit, or get dealt another card
    */
    func playerHit(){
        var card:Card = deck.deck.removeAtIndex(0)
        player.addCard(card)
        deck.deck.append(card)
        //nothing happens immediately right?
        if player.playerTotal > 21{
            playerLose()
        }
        // Game automatically runs the dealer turn if player gets 21
        if player.playerTotal == 21{
            dealerTurn()
        }
    }
    /**
    Dealer continues to hit as long as card total is less than 17
    */
    func dealerTurn(){
        var hiddenCard = dealer.revealHoleCard()
        // TODO: Hole card is revealed in gui
        while dealer.dealerTotal < 17{
            var card:Card = deck.deck.removeAtIndex(0)
            dealer.addCard(card)
            deck.deck.append(card)
        }
        if dealer.dealerTotal > 21{ // Dealer busts, player wins
            playerWin()
        }
        else if dealer.dealerTotal == player.playerTotal{ // Tie
                push()
        }
        else if dealer.dealerTotal > player.playerTotal{ // Whoever has the greatest total under 21 wins
            playerLose()
        }
        else if dealer.dealerTotal < player.playerTotal{
            playerWin()
        }
    }
    
    
    
}
