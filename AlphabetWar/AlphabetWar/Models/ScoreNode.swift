//
//  ScoreNode.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 2/7/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class ScoreNode: SKSpriteNode{
    
    let defaults = UserDefaults.standard
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var highScoreLabel:SKLabelNode!
    var highScore:Int = 0 {
        didSet {
            highScoreLabel.text = "HighScore: \(highScore)"
        }
    }

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    init(scene: GameScene) {
        super.init(texture: SKTexture(imageNamed: "life_transparent_bg_30") , color: UIColor.tertiarySystemBackground, size: CGSize(width: 175, height: 30))
        self.anchorPoint = CGPoint(x: self.size.width, y: 0)
        position = standByPosition(scene: scene)

        setUpScoreLabel(scene: scene)
        setUpHighScoreLabel(scene: scene)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpScoreLabel(scene: GameScene) {
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 0, y: 0)
        scoreLabel.fontSize = 20
        scoreLabel.horizontalAlignmentMode = .left
        
        scoreLabel.fontColor = UIColor.white
        score = 0
        self.addChild(scoreLabel)
    }
    
    private func setUpHighScoreLabel(scene: GameScene) {
        highScoreLabel = SKLabelNode(text: "HighScore: \(String(describing: highScore))")
        highScore = defaults.integer(forKey: "highScore")
        highScoreLabel.position = CGPoint(x: 0, y: -30)
        highScoreLabel.fontSize = 20
        highScoreLabel.horizontalAlignmentMode = .left
        
        highScoreLabel.fontColor = UIColor.white
        self.addChild(highScoreLabel)
    }
    
    func standByPosition(scene: GameScene) -> CGPoint {
        return CGPoint(x: -150, y: scene.frame.size.height - 70)
    }
    
    func playPosition(scene: GameScene) -> CGPoint {
        return CGPoint(x: 20, y: scene.frame.size.height - 70)
    }
    
    func show(scene: GameScene) {
        score = 0
        highScore = defaults.integer(forKey: "highScore")
        run(SKAction.move(to: playPosition(scene: scene), duration: 0.3))
    }
    
    func hide(scene: GameScene) {
        run(SKAction.move(to: standByPosition(scene: scene), duration: 0.3))
    }
}


