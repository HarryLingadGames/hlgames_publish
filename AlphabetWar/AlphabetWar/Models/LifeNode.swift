//
//  LifeNode.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 1/31/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class LifeNode: SKSpriteNode{

    var numberOfLife: Int = 0
    var lifeFires: [SKEmitterNode] = [SKEmitterNode]()
    var isDead: Bool = false

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    init(scene: GameScene){
        super.init(texture: SKTexture(imageNamed: "life_transparent_bg_30") , color: UIColor.tertiarySystemBackground, size: CGSize(width: 175, height: 30)) // clear_life_bg

        self.anchorPoint = CGPoint(x: 0, y: 0)

        self.position = oldPosition(scene: scene)
        initializeLifeImages()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initializeLifeImages() {

        numberOfLife = 5
        var currentLifeNumber = 0
        let coordinateX = 20

        while currentLifeNumber < numberOfLife {
            if let lifeFire = SKEmitterNode(fileNamed: "life_fire") {
                lifeFire.position = CGPoint(x: coordinateX * currentLifeNumber, y: 0)
                lifeFire.zPosition = -1
                lifeFires.append(lifeFire)
                currentLifeNumber = currentLifeNumber + 1
                self.addChild(lifeFire)
            }
        }
    }

    func removeOneLife() {
        if lifeFires.count > 0 {
            numberOfLife = numberOfLife - 1
            lifeFires.last?.removeFromParent()
            lifeFires.removeLast()
        }
        print("REMAINING LIFE : \(numberOfLife)")
    }

    func isUserDead() -> Bool{
        return numberOfLife <= 0
    }

    func newPosition(scene: GameScene) -> CGPoint{

        var positionY = 0
        if let sceneY = scene.view?.frame.height {
            positionY = Int(sceneY - 130)
        }

        return CGPoint(x: 25 , y: positionY)
    }

    func oldPosition(scene: GameScene) -> CGPoint{

        var positionY = 0
        if let sceneY = scene.view?.frame.height {
            positionY = Int(sceneY + 100)
        }

        return CGPoint(x: 25 , y: positionY)
    }
}

