//
//  AWGameGameOverComponents.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 1/31/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class AWGameGameOverComponents: NSObject{

    let defaults = UserDefaults.standard
    var gameOverPlayAgainButton: SKSpriteNode!
    var gameOverNode: SKSpriteNode!
    var quitNode: SKSpriteNode!


    var highScoreLabel:SKLabelNode!
    var highScore:Int = 0 {
        didSet {
            highScoreLabel.text = "HighScore: \(highScore)"
        }
    }

    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override init() {
        super.init()
    }

    init(gameScene: GameScene, score: Int){
        let heightDivided = gameScene.size.height / 8

        quitNode = SKSpriteNode(imageNamed: "quit")
        quitNode.size = CGSize(width: 50, height: 50)
        quitNode.position = CGPoint(x: quitNode.size.width, y: gameScene.size.height - quitNode.size.width)
        gameScene.addChild(quitNode)


        gameOverNode = SKSpriteNode(imageNamed: "gameover")
        gameOverNode.position = CGPoint(x: gameScene.size.width / 2, y: heightDivided * 6)
        gameOverNode.size = CGSize(width: 328, height: 234)
        gameScene.addChild(gameOverNode)

        gameOverPlayAgainButton = SKSpriteNode(imageNamed: "play_again")
        gameOverPlayAgainButton.position = CGPoint(x: gameScene.size.width / 2, y: heightDivided * 2)
        gameOverPlayAgainButton.size = CGSize(width: 120, height: 120)
        gameScene.addChild(gameOverPlayAgainButton)

        highScoreLabel = SKLabelNode(text: "HighScore: \(String(describing: highScore))")
        highScoreLabel.position = CGPoint(x: gameScene.frame.size.width / 2, y: heightDivided * 4)
        highScoreLabel.fontSize = 30
        highScoreLabel.fontColor = UIColor(red: 251, green: 174, blue: 21, alpha: 1)
        highScoreLabel.fontName = "Comic Sans MS"
        let newScore = defaults.integer(forKey: "highScore")
        highScoreLabel.text = "HighScore: \(newScore)"
        gameScene.addChild(highScoreLabel)

        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: gameScene.frame.size.width / 2, y: heightDivided * 3.5)  //"AmericanTypewriter-Bold"
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = UIColor(red: 251, green: 174, blue: 21, alpha: 1)
        scoreLabel.fontName = "Comic Sans MS"
        scoreLabel.text = "Score: \(score)"
        gameScene.addChild(scoreLabel)
    }

    func removeComponents(gameScene: GameScene){
        scoreLabel.isHidden = true
        highScoreLabel.isHidden = true
        gameOverPlayAgainButton.isHidden = true
        gameOverNode.isHidden = true
        quitNode.isHidden =  true

        scoreLabel.removeFromParent()
        highScoreLabel.removeFromParent()
        gameOverPlayAgainButton.removeFromParent()
        gameOverNode.removeFromParent()
        quitNode.removeFromParent()
    }
}

