//
//  AWGameStandByComponents.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 1/31/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class AWGameStandByComponents: NSObject{

    let defaults = UserDefaults.standard

    var gameStandbyPlayButton: SKSpriteNode!
    var gameLogoNode: SKSpriteNode!

    var highScoreLabel:SKLabelNode!
    var highScore:Int = 0 {
        didSet {
            highScoreLabel.text = "HighScore: \(highScore)"
        }
    }
    
    override init() {
        super.init()
    }
    
    init(gameScene: GameScene){
        gameLogoNode = SKSpriteNode(imageNamed: "logo")
        let heightDivided = gameScene.size.height / 8
        gameLogoNode.position = CGPoint(x: gameScene.size.width / 2, y: heightDivided * 5.5)
        gameLogoNode.size = CGSize(width: 328, height: 193)
        
        gameScene.addChild(gameLogoNode)
        
        gameStandbyPlayButton = SKSpriteNode(imageNamed: "play")
        gameStandbyPlayButton.position = CGPoint(x: gameScene.size.width / 2, y: heightDivided * 2)
        gameStandbyPlayButton.size = CGSize(width: 100, height: 120)
        gameScene.addChild(gameStandbyPlayButton)

        highScoreLabel = SKLabelNode(text: "HighScore: \(String(describing: highScore))")

        highScoreLabel.position = CGPoint(x: gameScene.frame.size.width / 2, y: heightDivided * 3.5)
        highScoreLabel.fontName = "Comic Sans MS"
        highScoreLabel.fontSize = 30
        highScoreLabel.fontColor = UIColor(red: 251, green: 174, blue: 21, alpha: 1)

        highScoreLabel.fontColor = UIColor.white
        let newScore = defaults.integer(forKey: "highScore")
        highScoreLabel.text = "HighScore: \(newScore)"
        gameScene.addChild(highScoreLabel)
    }
    
    func removeComponents(gameScene: GameScene){

        highScoreLabel.isHidden = true
        gameStandbyPlayButton.isHidden = true
        gameLogoNode.isHidden = true
        highScoreLabel.removeFromParent()
        gameStandbyPlayButton.removeFromParent()
        gameLogoNode.removeFromParent()
    }
}

