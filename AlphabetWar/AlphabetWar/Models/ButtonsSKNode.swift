//
//  ButtonsSKNode.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 1/31/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import SpriteKit

class ButtonsSKNode: SKSpriteNode{
    
    init(gameScene: GameScene, color: UIColor, size: CGSize){
        super.init(texture: nil, color: color, size: size)
        setHeight()
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHeight(){
        
        let pixelValue = self.size.width / GameDimension.NUMBER_OF_PIXEL
        self.size.height = (pixelValue * (158 + 10))
        
    }
}

