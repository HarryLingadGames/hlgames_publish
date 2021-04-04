//
//  GameScene+GameOver.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 1/31/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

extension GameScene{
    func initializeGameOverComponents(score: Int){
        gameOverComponents = AWGameGameOverComponents(gameScene: self, score: score)
    }

    func enableContinueButton() {
        gameOverComponents.gameOverPlayAgainButton.isUserInteractionEnabled = true
    }
}
