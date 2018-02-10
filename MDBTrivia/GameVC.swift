    //
//  MainScreenVCViewController.swift
//  MDBTrivia
//
//  Created by Ethan Wong on 2/8/18.
//  Copyright © 2018 Ethan Wong. All rights reserved.
//

import UIKit
    
var score : Int = 0

class GameVC: UIViewController {
    var button1 : UIButton!
    var button2 : UIButton!
    var button3 : UIButton!
    var button4 : UIButton!
    var memberPic : UIImageView!
    var randomImageGen : Int!
    var randomButtonGen : Int!
    var scoreLabel : UILabel!
    //var pastThreeAnswers = [String]()
    var oneAnswerAgo: String!
    //var twoAnswerAgo: String!
    //var threeAnswerAgo: String!
    //var currentStreak: Int!
    var toStats = false
    

    let memberNames : [String] = ["Daniel Andrews", "Nikhar Arora", "Tiger Chen", "Xin Yi Chen", "Julie Deng", "Radhika Dhomse", "Kaden Dippe", "Angela Dong", "Zach Govani", "Shubham Gupta", "Suyash Gupta", "Joey Hejna", "Cody Hsieh", "Stephen Jayakar", "Aneesh Jindal", "Mohit Katyal", "Mudabbir Khan", "Akkshay Khoslaa", "Justin Kim", "Eric Kong", "Abhinav Koppu", "Srujay Korlakunta", "Ayush Kumar", "Shiv Kushwah", "Leon Kwak", "Sahil Lamba", "Young Lin", "William Lu", "Louie McConnell", "Max Miranda", "Will Oakley", "Noah Pepper", "Samanvi Rai", "Krishnan Rajiyah", "Vidya Ravikumar", "Shreya Reddy", "Amy Shen", "Wilbur Shi", "Sumukh Shivakumar", "Fang Shuo", "Japjot Singh", "Victor Sun", "Sarah Tang", "Kanyes Thaker", "Aayush Tyagi", "Levi Walsh", "Carol Wang", "Sharie Wang", "Ethan Wong", "Natasha Wong", "Aditya Yadav", "Candice Ye", "Vineeth Yeevani", "Jeffrey Zhang"]
    
    var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        createStopButton()
        createScore()
        gameStart()
    }
    
    //Segue Back To Start Screen
    @objc func backToStart() {
        pauseGame()
        performSegue(withIdentifier: "StartScreen", sender: self)
    }
    
    //Create Stop Button
    func createStopButton() {
        stopButton = UIButton(frame: CGRect(x:20, y: 600, width: view.frame.width - 40, height: 40))
        stopButton.backgroundColor = .red
        stopButton.setTitle(("Stop"), for: .normal)
        stopButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
        stopButton.layer.cornerRadius = stopButton.frame.height / 2
        stopButton.addTarget(self, action: #selector(backToStart), for: .touchUpInside)
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
        memberPic.layer.cornerRadius = memberPic.frame.size.width / 2
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
    
    func clearVC() {
        memberPic.image = nil
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
    }
    
    //If correct answer is pressed.
    @objc func selectCorrectAns(_ sender: UIButton){
        score += 1
        //global score
        //streak
        clearVC()
        sender.backgroundColor = .green
        //timer 1 sec delay
        gameStart()
    }
    
    //If wrong answer is pressed.
    @objc func selectWrongAns(_ sender: UIButton) {
        //global score
        //streak
        //Remove previous image so they don't stack on top of each other.
        clearVC()
        sender.backgroundColor = .red
        //timer 1 sec delay
        gameStart()
    }
    
    func gameStart() {
        var randomImageIndex:Int!
        var correctAns: String!
        var memberIndex = 0
        var randCorrectAnsIndex: Int!
        var selectedMembers = [String]()
        
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
    
    //Stop the timer.
    func pauseGame () {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(toStats){ //create button on navbar, when pressed, set toStats to true
            let statsViewController = segue.destination as! StatsVC
            statsViewController.longestStreak = oneAnswerAgo
        }
        
    }
}
