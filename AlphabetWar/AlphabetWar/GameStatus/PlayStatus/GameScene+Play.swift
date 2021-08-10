//
//  GameScene+Play.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 1/31/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

extension GameScene: GameViewControllerProtocol{
    func gotoBackGround() {

        self.isPaused = true
//        gameOverComponents.removeComponents(gameScene: self)
//        playComponents.removeComponents(gameScene: self)
//        initializeStandByComponents()
//        initializePlayComponents()
//        gameStatus = GameStatus.StandBy
    }


    func initializePlayComponents() {
        playComponents = AWGamePlayComponents(gameScene: self)
    }
    
    @objc func addEnemyLetter () {
        if gameStatus == GameStatus.Play && !(scene?.isPaused ?? true) {
            playComponents.enemyLetterNames = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: playComponents.enemyLetterNames) as! [LetterType]

            let letter = EnemyLetterNode(gameScene: self, type: playComponents.enemyLetterNames[0])
            self.addChild(letter)

            enemyCounter = enemyCounter + 1

            playComponents.activeEnemyLetter.append(letter)
            letter.run(SKAction.sequence(letter.actionArray))
        }
    }
    
    func fireTorpedo(type: LetterType) {
        var hasFired = false
        for activeLetter in playComponents.activeEnemyLetter {
            if activeLetter.type == type && !hasFired {
                self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
                let torpedoNode = TorpedoNode(imageNamed: "torpedo", gameScene: self, targetLetter: activeLetter)
                playComponents.activeTorpedo.append(torpedoNode)
                torpedoNode.run(SKAction.sequence(torpedoNode.actionArray))
                hasFired = true
            }
        }
    }
    
    func torpedoDidCollideWithAlien (torpedoNode: TorpedoNode, enemyLetter: EnemyLetterNode) {
        
        let explosion = SKEmitterNode(fileNamed: "TestSpark")!
        explosion.position = enemyLetter.position
        
        self.addChild(explosion)
        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        if self.playComponents.activeEnemyLetter.count > 0 {
            let testIndex = self.playComponents.activeEnemyLetter.firstIndex(of: enemyLetter )
            self.playComponents.activeEnemyLetter.remove(at: testIndex ?? 0).remove()
        }
        
        if self.playComponents.activeTorpedo.count > 0 {
            let testIndex = self.playComponents.activeTorpedo.firstIndex(of: torpedoNode )
            self.playComponents.activeTorpedo.remove(at: testIndex ?? 0)
        }
        
        torpedoNode.removeFromParent()
        enemyLetter.remove()
        
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
        
        playComponents.recordNode.score += 1

        if playComponents.recordNode.score % GameDimension.SCORE_TO_INCREASE_LEVEL == 0 {
            playComponents.level += 1
            
            playComponents.gameTimer.invalidate()
            print("PLAYER LEVEL : \(playComponents.level)")
            let enemyAppearanceTimeInterval = Double(GameDimension.TIME_ENEMY_WILL_APPEAR) - (Double(playComponents.level) * 0.05)
            playComponents.gameTimer = Timer.scheduledTimer(timeInterval: enemyAppearanceTimeInterval, target: self, selector: #selector(addEnemyLetter), userInfo: nil, repeats: true)
        }
    }

    func enemyLetterTouchTheFloorExplode(enemyLetter: EnemyLetterNode) {
        self.playComponents.lifeNode.removeOneLife()
        if playComponents.lifeNode.isUserDead() {

            if playComponents.recordNode.score > playComponents.recordNode.highScore {
                playComponents.defaults.set(playComponents.recordNode.score, forKey: "highScore")
            }

            playComponents.hideAllComponents(gameScene: self)
            keyBoardDelegate?.hideKeyBoard()
            initializeGameOverComponents(score: playComponents.recordNode.score)
            gameStatus = .GameOver
            
//            if playComponents.numberOfGameOver / 5 == 1 {
//                keyBoardDelegate?.openAudienceNetwork()
//            } else

            debugPrint("numberOfGameOver: \(playComponents.numberOfGameOver)")

            if playComponents.numberOfGameOver / 3 == 1 {
                playComponents.numberOfGameOver = 1
                playComponents.defaults.set(playComponents.numberOfGameOver, forKey: "numberOfGameOver")
                playComponents.scene.shouldOpenAd = true
                keyBoardDelegate?.openAudienceNetwork()
            }else {
                playComponents.numberOfGameOver += 1
                playComponents.defaults.set(playComponents.numberOfGameOver, forKey: "numberOfGameOver")

            }

            setLife()
        }

        if let explosion = SKEmitterNode(fileNamed: "base_explosion") {
            explosion.position = enemyLetter.position
            self.addChild(explosion)
            
            self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
            
            let testIndex = self.playComponents.activeEnemyLetter.firstIndex(of: enemyLetter)
            self.playComponents.activeEnemyLetter.remove(at: testIndex ?? 0).remove()
            
            self.run(SKAction.wait(forDuration: 2)) {
                explosion.removeFromParent()
            }
        }
    }
    
    func playButtonExplode() {
        if let explosion = SKEmitterNode(fileNamed: "Explosion"){
            explosion.position = (standByComponents.gameLogoNode.position)
            self.addChild(explosion)
            
            self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
            self.run(SKAction.wait(forDuration: 1)) {
                explosion.removeFromParent()
                self.playComponents.showAllComponents(scene: self)
            }
        }
    }

    func setLife() {
        let currentLife = playComponents.defaults.integer(forKey: "life_count")
        let newLife = currentLife - 5
        playComponents.defaults.set(newLife, forKey: "life_count")
    }

    
//    func didBegin(_ contact: SKPhysicsContact) {
//
//           var firstBody:SKPhysicsBody
//           var secondBody:SKPhysicsBody
//
//           if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
//               firstBody = contact.bodyA
//               secondBody = contact.bodyB
//           }else{
//               firstBody = contact.bodyB
//               secondBody = contact.bodyA
//           }
//
//           if (firstBody.categoryBitMask & playComponents.photonTorpedoCategory) != 0 && (secondBody.categoryBitMask & playComponents.enemyLetterCategory) != 0 {
//               torpedoDidCollideWithAlien(torpedoNode: firstBody.node as! TorpedoNode, enemyLetter: secondBody.node as! EnemyLetterNode)
//           }
//       }
}

