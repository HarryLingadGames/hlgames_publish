//
//  TargetNode.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 1/31/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import Foundation
import SpriteKit

class TargetNode: SKSpriteNode{
    
    var hasTarget: Bool = false
    var targetLetter: EnemyLetterNode?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    init(gameScene: GameScene, imageNamed: String, hasTarget: Bool){
        super.init(texture: SKTexture(imageNamed: imageNamed), color: UIColor.white, size: CGSize(width: 75, height: 75))
        self.position = CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height / 2)
        gameScene.addChild(self)
        self.isHidden = true
        targetLetter = nil
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTarget(target: EnemyLetterNode) {
        targetLetter = target
        hasTarget = true
    }
    
    func removeTarget(){
        print("LAST TARGET: \(String(describing: targetLetter?.type?.rawValue))")
        targetLetter?.remove()
        targetLetter = nil
        hasTarget = false
    }
    
    func targetType() -> LetterType{
        return self.targetLetter?.type ?? LetterType.a
    }
    
    func followTarget(){
        if let target = self.targetLetter{
           self.position = target.position
        }
    }
}

