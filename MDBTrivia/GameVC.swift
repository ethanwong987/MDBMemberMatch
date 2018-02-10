    //
//  MainScreenVCViewController.swift
//  MDBTrivia
//
//  Created by Ethan Wong on 2/8/18.
//  Copyright © 2018 Ethan Wong. All rights reserved.
//

import UIKit
    
var score : Int = 0
var longestStreak: Int = 0
var oneAnswerAgo: [String] = []
var twoAnswerAgo: [String] = []
var threeAnswerAgo: [String] = []
    
class GameVC: UIViewController {
    //InitialLoad
    var button1 : UIButton!
    var button2 : UIButton!
    var button3 : UIButton!
    var button4 : UIButton!
    var memberPic : UIImageView!
    var randomImageGen : Int!
    var randomButtonGen : Int!
    var scoreLabel : UILabel!
    var numQustions: Int = 0
    var wrongMember: String!
    //Stats
    var senderLabel: String!
    var currentStreak: Int = 0
    var longestStreak: Int = 0
    var toStats = false
    var toMain = false
    //Timer
    var seconds = 5
    var timer = Timer()
    var isTimerRunning = false

    let memberNames : [String] = ["Daniel Andrews", "Nikhar Arora", "Tiger Chen", "Xin Yi Chen", "Julie Deng", "Radhika Dhomse", "Kaden Dippe", "Angela Dong", "Zach Govani", "Shubham Gupta", "Suyash Gupta", "Joey Hejna", "Cody Hsieh", "Stephen Jayakar", "Aneesh Jindal", "Mohit Katyal", "Mudabbir Khan", "Akkshay Khoslaa", "Justin Kim", "Eric Kong", "Abhinav Koppu", "Srujay Korlakunta", "Ayush Kumar", "Shiv Kushwah", "Leon Kwak", "Sahil Lamba", "Young Lin", "William Lu", "Louie McConnell", "Max Miranda", "Will Oakley", "Noah Pepper", "Samanvi Rai", "Krishnan Rajiyah", "Vidya Ravikumar", "Shreya Reddy", "Amy Shen", "Wilbur Shi", "Sumukh Shivakumar", "Fang Shuo", "Japjot Singh", "Victor Sun", "Sarah Tang", "Kanyes Thaker", "Aayush Tyagi", "Levi Walsh", "Carol Wang", "Sharie Wang", "Ethan Wong", "Natasha Wong", "Aditya Yadav", "Candice Ye", "Vineeth Yeevani", "Jeffrey Zhang"]
    
    var stopButton: UIButton!
    var statsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        createStopButton()
        createStatsButton()
        createScore()
        gameStart()
    }
    
    //To Stats Button
    func createStatsButton() {
        
        let scnHeight = view.frame.height
        let scnWidth = view.frame.width
        
        statsButton = UIButton(frame: CGRect(x:scnWidth*0.75, y: scnHeight*0.05, width: view.frame.width * 0.2, height: 40))
        statsButton.backgroundColor = .red
        statsButton.setTitle(("Stats"), for: .normal)
        statsButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15)
        statsButton.layer.cornerRadius = stopButton.frame.height / 4
        statsButton.addTarget(self, action:#selector(goToStatsScreen), for: .touchUpInside)
        view.addSubview(statsButton)
    }

    @objc func goToStatsScreen() {
        pauseGame()
        toStats = true
        performSegue(withIdentifier: "StatsScreen", sender: self)
    }
    
    //Create Stop Button
    func createStopButton() {
        let scnHeight = view.frame.height
        let scnWidth = view.frame.width
        stopButton = UIButton(frame: CGRect(x:view.frame.width*0.05, y: view.frame.height*0.9, width: view.frame.width - 40, height: 40))
        stopButton.backgroundColor = .red
        stopButton.setTitle(("Pause"), for: .normal)
        stopButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
        stopButton.layer.cornerRadius = stopButton.frame.height / 2
        stopButton.addTarget(self, action: #selector(pauseGame), for: .touchUpInside)

        view.addSubview(stopButton)
    }
    
    func createScore() {
        scoreLabel = UILabel(frame: CGRect(x:view.frame.width * 0.08, y:view.frame.height/1.95, width: view.frame.width - 60, height: 45))
        scoreLabel.text = "Score: \(score)"
        scoreLabel.textColor = .black
        scoreLabel.font = UIFont.systemFont(ofSize: 20)
        scoreLabel.textAlignment = .left
        view.addSubview(scoreLabel)
    }
    
    //Create Default Answer Buttons w/ titles not set

    func createAnswerButtons() {
        let scnHeight = view.frame.height
        let scnWidth = view.frame.width
        let btnWidth = scnWidth / 2.5
        let btnHeight = scnHeight / 9
        button1 = UIButton(frame: CGRect(x:scnWidth * 0.07, y: scnHeight * 0.58, width: btnWidth, height: btnHeight))
        button2 = UIButton(frame: CGRect(x:scnWidth * 0.53, y: scnHeight * 0.58, width: btnWidth, height: btnHeight))
        button3 = UIButton(frame: CGRect(x:scnWidth * 0.07, y: scnHeight * 0.73, width: btnWidth, height: btnHeight))
        button4 = UIButton(frame: CGRect(x:scnWidth * 0.53, y: scnHeight * 0.73, width: btnWidth, height: btnHeight))
        
        buttonDefaults(button1)
        buttonDefaults(button2)
        buttonDefaults(button3)
        buttonDefaults(button4)
    }
    
    func generateImage(_ name :String){
        let scnHeight = view.frame.height
        let scnWidth = view.frame.width
        memberPic = UIImageView(frame: CGRect(x:scnWidth * 0.15, y:scnHeight * 0.12, width: scnWidth * 0.7, height:scnHeight * 0.4))
        memberPic.image = UIImage(named: name)
        memberPic.contentMode = .scaleAspectFit
        memberPic.clipsToBounds = true
        memberPic.layer.borderColor = UIColor.blue.cgColor
        memberPic.layer.borderWidth = 4
        view.addSubview(memberPic)
    }
    
    func buttonDefaults(_ button: UIButton) {
        button.backgroundColor = .blue
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 12)
        button.layer.cornerRadius = button.frame.height / 4
        view.addSubview(button)
    }
    
    //If correct answer is pressed.
    @objc func selectCorrectAns(_ sender: UIButton){
        senderLabel = sender.title(for: .normal)
        
        oneAnswerAgo = twoAnswerAgo
        twoAnswerAgo = threeAnswerAgo
        threeAnswerAgo = []
        threeAnswerAgo.append("Correct: \(senderLabel!)")
        score += 1
        currentStreak += 1
        if currentStreak > longestStreak {
            longestStreak = currentStreak
        }
        sender.backgroundColor = .green
        seconds = 1
        resetTimer()
    }

    //If wrong answer is pressed.
    @objc func selectWrongAns(_ sender: UIButton) {
        senderLabel = sender.title(for: .normal)
        oneAnswerAgo = twoAnswerAgo
        twoAnswerAgo = threeAnswerAgo
        threeAnswerAgo = []
        threeAnswerAgo.append("Wrong: \(senderLabel!)")
        
        if currentStreak > longestStreak {
            longestStreak = currentStreak
        }
        currentStreak = 0
        sender.backgroundColor = .red
        seconds = 1
        resetTimer()
    }
    
    func gameStart() {
        var randomImageIndex:Int!
        var correctAns: String!
        var memberIndex = 0
        var randCorrectAnsIndex: Int!
        var selectedMembers = [String]()
        
        if isTimerRunning == false {
            runTimer()
            isTimerRunning = true
        }
        
        //Keeps tally of how many questions have been asked.
        numQustions += 1
        
        //Select 4 random members, then assign 1 randomly as correctAns.
        while selectedMembers.count < 4 {
            randomImageIndex = Int(arc4random_uniform(54))
            if selectedMembers.contains(memberNames[randomImageIndex]) {
                randomImageIndex = Int(arc4random_uniform(54))
            } else {
                selectedMembers.append(memberNames[randomImageIndex])
            }
        }
        randCorrectAnsIndex = Int(arc4random_uniform(4))
        correctAns = selectedMembers[randCorrectAnsIndex]
        
        //Generate image of member according to correctAns
        correctAns = correctAns.lowercased()
        correctAns = correctAns.replacingOccurrences(of: " ", with: "")
        generateImage(correctAns)
        
        //Generate 4 buttons, assign name and action
        createAnswerButtons()
        let buttonsArray: [UIButton] = [button1, button2, button3, button4]
        for button in buttonsArray {
            if (memberIndex == randCorrectAnsIndex) {
                button.setTitle(selectedMembers[memberIndex], for: .normal)
                button.addTarget(self, action: #selector(selectCorrectAns), for: .touchUpInside)
                if(memberIndex == 3){
                } else {
                    memberIndex += 1
                }
            } else {
                button.setTitle(selectedMembers[memberIndex], for: .normal)
                button.addTarget(self, action: #selector(selectWrongAns), for: .touchUpInside)
                memberIndex += 1
            }
        }
        scoreLabel.removeFromSuperview()
        createScore()
    }
    
    //Timer
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameVC.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        
        if seconds <= 0 {
            gameStart()
            seconds = 5
            resetTimer()
        }
    }
    
    func resetTimer() {
        timer.invalidate()
        runTimer()
        isTimerRunning = true
    }
    
    @objc func pauseGame() {
        timer.invalidate()
        isTimerRunning = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(toStats){
            let statsViewController = segue.destination as! StatsVC
            statsViewController.longestStreak = longestStreak
        }
        
    }
}
