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

protocol AWGameStandByNavigationProtocol {
    func goToInAppPurchaseScreen()
}

class AWGameStandByComponents: NSObject{

    let defaults = UserDefaults.standard

    var buyLifeButton: SKSpriteNode!
    var gameStandbyPlayButton: SKSpriteNode!

    var gameLogoNode: SKSpriteNode!

    var numberOfLife: SKLabelNode!
    var highScoreLabel: SKLabelNode!
    var amountOfLifeLabel: SKLabelNode!

    var highScore:Int = 0 {
        didSet {
            highScoreLabel.text = "HighScore: \(highScore)"
        }
    }

    var amountOfLife:Int {
        get {
            let originalLifeCount = defaults.integer(forKey: "life_count")

            if originalLifeCount <= AWThresholds.LIFE_CONDITION_THRESHOLD {
                let oldTime = defaults.integer(forKey: "time")

                print("OLD TIME : \(oldTime)")

                // using current date and time as an example
                let newDate = Date()

                // convert Date to TimeInterval (typealias for Double)
                let timeInterval = newDate.timeIntervalSince1970
                let timeIntervalInMinutes = Int(timeInterval / AWThresholds.CONVERT_MINUTES)
                print("NEW TIME : \(timeIntervalInMinutes)")

                defaults.setValue(timeIntervalInMinutes , forKey: "time")

                let timeThatPass = timeIntervalInMinutes - oldTime
                print("TIME : \(timeThatPass)")

                let lifeMultiple = Int(timeThatPass / AWThresholds.LIFE_MULTIPLE)

                if lifeMultiple > 0 {
                    let lifeToBeAdd = lifeMultiple * AWThresholds.LIFE_MULTIPLE
                    let newLifeCount = originalLifeCount + lifeToBeAdd
                    defaults.setValue(newLifeCount, forKey: "life_count")
                }
            }
            return defaults.integer(forKey: "life_count")
        }
    }

    var navigationDelegate: AWGameStandByNavigationProtocol?
    
    override init() {
        super.init()
    }
    
    init(gameScene: GameScene){
        super.init()
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

        amountOfLifeLabel = SKLabelNode(text: "Life: \(String(describing: highScore))")

        amountOfLifeLabel.position = CGPoint(x: gameScene.frame.size.width / 2, y: heightDivided * 3)
        amountOfLifeLabel.fontName = "Comic Sans MS"
        amountOfLifeLabel.fontSize = 30
        amountOfLifeLabel.fontColor = UIColor(red: 251, green: 174, blue: 21, alpha: 1)

        amountOfLifeLabel.fontColor = UIColor.white
        let remainingLife = self.amountOfLife
        amountOfLifeLabel.text = "Life: \(remainingLife)"
        gameScene.addChild(amountOfLifeLabel)

        buyLifeButton = SKSpriteNode(imageNamed: "cart")
        buyLifeButton.size = CGSize(width: 75, height: 75)
        let buyLifeButtonX = gameScene.size.width - buyLifeButton.size.width
        buyLifeButton.position = CGPoint(x: buyLifeButtonX, y: buyLifeButton.size.height)
        gameScene.addChild(buyLifeButton)
    }
    
    func removeComponents(gameScene: GameScene){
        highScoreLabel.isHidden = true
        highScoreLabel.removeFromParent()

        amountOfLifeLabel.isHidden = true
        amountOfLifeLabel.removeFromParent()

        gameStandbyPlayButton.isHidden = true
        gameStandbyPlayButton.removeFromParent()

        gameLogoNode.isHidden = true
        gameLogoNode.removeFromParent()

        buyLifeButton.isHidden = true
        buyLifeButton.removeFromParent()
    }
}

