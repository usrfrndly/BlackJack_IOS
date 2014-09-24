//
//  ViewController.swift
//  Blckjack
//
//  Created by Jaclyn May on 9/9/14.
//  Copyright (c) 2014 iOSProgramming. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var blackJack = BlackjackModel()
    
    
    func refreshUI(){
        fundsTextField.text = String(format:"%0.2f", blackJack.player.funds)
        betTextField.text = String(format:"%0.2f", blackJack.player.playerBet)
        playerHandTextView.text=String(blackJack.player.playerHand.description)
        var dHand:[Card]=blackJack.dealer.dealerHand
        var dealer_Card_names:String=""
        if !dHand.isEmpty && dHand.count <= 2 && blackJack.gameOverMessage == nil{
        
            dealer_Card_names = "[" + "HoleCard"
            for i in 1..<dHand.count{
                dealer_Card_names += ", " + dHand[i].name
            }
            dealer_Card_names += "]"
            dealerHandTextView.text = dealer_Card_names
        }
        if blackJack.gameOverMessage != nil {
            dealerHandTextView.text = String(blackJack.dealer.dealerHand.description)
            gameOver()
        }
    }
    
    @IBOutlet var fundsTextField: UITextField!
    @IBOutlet var betTextField: UITextField!
    @IBOutlet var dealerScore: UITextField!
    @IBOutlet var playerScore: UITextField!
    @IBOutlet var playerHandTextView : UITextView!
    @IBOutlet var dealerHandTextView : UITextView!
    @IBOutlet var errorMessageField : UITextView!
    @IBOutlet var gameOverField : UITextView!
    @IBOutlet var hitButton : UIButton!
    @IBOutlet var stayButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newGame(sender:AnyObject){
        playerScore.hidden = true
        dealerScore.hidden = true
        gameOverField.text = ""
        errorMessageField.text = ""
        blackJack.newGame()
        refreshUI()
    }

    @IBAction func bet(sender:AnyObject){
        var betString = NSString(string: betTextField.text)
        if !blackJack.player.bet(betString.doubleValue){
            errorMessageField.text = "Your bet must be at least $1 and not exceed your funds"
        }
        else{
            errorMessageField.text = ""
            hitButton.hidden = false
            stayButton.hidden = false
            blackJack.deal()
            refreshUI()
        }
    }
    
    @IBAction func hit(sender:AnyObject){
    blackJack.playerHit()
    refreshUI()
    }
    @IBAction func stay(sender:AnyObject){
        blackJack.dealerTurn()
        refreshUI()
    }
    func gameOver(){
        hitButton.hidden = true
        stayButton.hidden = true
        gameOverField.text = blackJack.gameOverMessage
        playerScore.text = String(blackJack.player.playerTotal)
        dealerScore.text = String(blackJack.dealer.calculateTotal())
        playerScore.hidden = false
        dealerScore.hidden = false
    }
    
    


}

