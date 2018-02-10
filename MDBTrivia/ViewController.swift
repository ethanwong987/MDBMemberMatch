//
//  ViewController.swift
//  MDBTrivia
//
//  Created by Ethan Wong on 2/8/18.
//  Copyright © 2018 Ethan Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var startButton: UIButton!
    var BGImage: UIImageView!
    var gameTitle: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        goToMainScreen()
        createBGImage()
        createStartButton()
        createGameTitle()
        
        // Do any additional setup after loading the view, typically from a nib.\
    }
    
    //Segue to GameScreen
    @objc func goToMainScreen() {
        performSegue(withIdentifier: "MainScreen", sender: self)
    }
    
    //Create Background Image
    func createBGImage() {
        BGImage = UIImageView(frame: CGRect(x:0, y:-100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        BGImage.image = UIImage(named: "MDBLogo")
        BGImage.contentMode = .scaleAspectFit
        view.addSubview(BGImage)
    }
    
    //Create Start Button
    func createStartButton() {
        startButton = UIButton(frame: CGRect(x:view.frame.width*0.05, y: view.frame.height*0.9, width: view.frame.width - 40, height: 40))
        startButton.backgroundColor = .blue
        startButton.setTitle(("Start"), for: .normal)
        startButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = startButton.frame.height / 2
        startButton.addTarget(self, action: #selector(goToMainScreen), for: .touchUpInside)
        view.addSubview(startButton)
        
    }
    
    //Create Game Title
    func createGameTitle() {
        gameTitle = UILabel(frame: CGRect(x:30, y:view.frame.height/2, width: view.frame.width - 60, height: 45))
        gameTitle.numberOfLines = 0
        gameTitle.text = "Member Match!"
        gameTitle.textColor = .blue
        gameTitle.font = UIFont.systemFont(ofSize: 35)
        gameTitle.textAlignment = .center
        view.addSubview(gameTitle)
    }


}

