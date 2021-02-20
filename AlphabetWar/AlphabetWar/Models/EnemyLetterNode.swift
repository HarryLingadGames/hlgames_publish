//
//  EnemyLetterNode.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 1/31/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class EnemyLetterNode: SKSpriteNode{

    var type: LetterType?
    var actionArray = [SKAction]()
    var letterSmoke: SKEmitterNode = SKEmitterNode()
    var isShot = false


    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init(gameScene: GameScene, type: LetterType){
        super.init(texture: SKTexture(imageNamed: type.rawValue), color: UIColor.white, size: CGSize(width: 40, height: 40))
        self.type = type
        self.position(gameScene: gameScene)
        self.categories(gameScene: gameScene)
        self.smoke(gameScene: gameScene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func position(gameScene: GameScene){
        let allowance = Int(self.size.width) / 2
        let randomAlienPosition = GKRandomDistribution(lowestValue: allowance, highestValue: Int(gameScene.size.width) - allowance)
        let position = CGFloat(randomAlienPosition.nextInt())
        self.position = CGPoint(x: position, y: gameScene.frame.size.height + self.size.height)

        let speedFallingOfEnemyLetter =  Int(GameDimension.ENEMYLETTER_SPEED_OF_FALLING) - Int(gameScene.playComponents.level)
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -10), duration: TimeInterval(speedFallingOfEnemyLetter)))
        actionArray.append(SKAction.removeFromParent())
    }
    
    private func categories(gameScene: GameScene){
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        
        self.physicsBody?.categoryBitMask = gameScene.playComponents.enemyLetterCategory
        self.physicsBody?.contactTestBitMask = gameScene.playComponents.photonTorpedoCategory
        self.physicsBody?.collisionBitMask = 0
    }

    private func smoke(gameScene: GameScene) {
        if let smoke = SKEmitterNode(fileNamed: "meteor_tail"){
            letterSmoke = smoke
            let toBeAdded = self.size.height / 2
            letterSmoke.position = CGPoint(x: position.x, y: position.y - toBeAdded)
            letterSmoke.zPosition = -1
            gameScene.addChild(letterSmoke)
        }
    }

    func runSmoke() {
        letterSmoke.position.x = self.position.x
        letterSmoke.position.y = self.position.y - (self.size.height / 4)
    }

    func remove() {
        letterSmoke.removeFromParent()
        self.removeFromParent()
    }
}

