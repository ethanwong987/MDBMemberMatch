//
//  StatsVC.swift
//  MDBTrivia
//
//  Created by Ethan Wong on 2/9/18.
//  Copyright © 2018 Ethan Wong. All rights reserved.
//

import UIKit

class StatsVC: UIViewController {
    var longestStrkButton: UILabel!
    var lastAnswer: UILabel!
    var secondLastAnswer: UILabel!
    var thirdLastAnswer: UILabel!
    var longestStreak: Int!
    var btg : UIButton!
    var toStats : Bool!
    var toMain : Bool!
    var three : UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToGame()
        displayScore()
        createPastThreeAnswers()
        createLabel()
    }
    
    func createLabel(){
        three = UILabel(frame: CGRect(x:30, y:200, width: view.frame.width - 60, height: 45))
        three.text = "Last 3 Results:"
        three.textColor = .blue
        three.font = UIFont.systemFont(ofSize: 25)
        three.textAlignment = .center
        view.addSubview(three)
    }
    
    func createPastThreeAnswers(){
        lastAnswer = UILabel(frame: CGRect(x:30, y:300, width: view.frame.width - 60, height: 45))
        lastAnswer.numberOfLines = 0
        if oneAnswerAgo != [] {
            lastAnswer.text = oneAnswerAgo[0]
        }
        lastAnswer.font = UIFont.systemFont(ofSize: 25)
        lastAnswer.textColor = .blue
        lastAnswer.textAlignment = .center
        view.addSubview(lastAnswer)
        
        secondLastAnswer = UILabel(frame: CGRect(x:30, y:400, width: view.frame.width - 60, height: 45))
        secondLastAnswer.numberOfLines = 0
        if twoAnswerAgo != [] {
            secondLastAnswer.text = twoAnswerAgo[0]
            }
        secondLastAnswer.font = UIFont.systemFont(ofSize: 25)
        secondLastAnswer.textColor = .blue
        secondLastAnswer.textAlignment = .center
        view.addSubview(secondLastAnswer)
        
        thirdLastAnswer = UILabel(frame: CGRect(x:30, y:500, width: view.frame.width - 60, height: 45))
        thirdLastAnswer.numberOfLines = 0
        if threeAnswerAgo != [] {
            thirdLastAnswer.text = threeAnswerAgo[0]
            }
        thirdLastAnswer.textColor = .blue
        thirdLastAnswer.font = UIFont.systemFont(ofSize: 25)
        thirdLastAnswer.textAlignment = .center
        view.addSubview(thirdLastAnswer)
    }
    
    func displayScore() {
        longestStrkButton = UILabel(frame: CGRect(x:view.frame.width * 0.1, y:view.frame.height/8, width: view.frame.width - 60, height: 45))
        longestStrkButton.numberOfLines = 0
        longestStrkButton.text = "Your Longest streak: \(longestStreak!)"
        longestStrkButton.textColor = .blue
        longestStrkButton.font = UIFont.systemFont(ofSize: 20)
        longestStrkButton.textAlignment = .center
        view.addSubview(longestStrkButton)
    }
    //create
    func backToGame() {
        let scnHeight = view.frame.height
        let scnWidth = view.frame.width
        btg = UIButton(frame: CGRect(x:scnWidth*0.07, y: scnHeight*0.05, width: view.frame.width * 0.2, height: 40))
        btg.backgroundColor = .red
        btg.setTitle(("Back"), for: .normal)
        btg.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15)
        btg.layer.cornerRadius = btg.frame.height / 4
        btg.addTarget(self, action:#selector(goToMainScreen), for: .touchUpInside)
        btg.addTarget(self, action: #selector(resumeGame), for: .touchUpInside)
        view.addSubview(btg)
    }
    
    @objc func goToMainScreen() {
        toStats = false
        toMain = true
        performSegue(withIdentifier: "BackToGame", sender: self)
    }
    
    @objc func resumeGame() {
        
    }
    //set toStats to false
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(toMain){ //create button on navbar, when pressed, set toStats to true
            let gamevc = segue.destination as! GameVC
            gamevc.timer.invalidate()
            if gamevc.isTimerRunning == false {
                gamevc.isTimerRunning = false
            } else {
                gamevc.isTimerRunning = true
            }
        }
}


}
