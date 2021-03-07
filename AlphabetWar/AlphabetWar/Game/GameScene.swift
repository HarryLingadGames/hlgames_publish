//
//  GameScene.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 1/31/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

protocol KeyBoardProtocol {
    func showKeyboard()
    func hideKeyBoard()
    func openAdmob()
    func openAudienceNetwork()
//    func openRateMe()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var xAcceleration:CGFloat = 0
    var playComponents: AWGamePlayComponents!
    var standByComponents: AWGameStandByComponents!
    var gameOverComponents: AWGameGameOverComponents!
    
    var gameStatus: GameStatus = GameStatus.StandBy
    var enemyCounter: Int = 0

    var keyBoardDelegate: KeyBoardProtocol?

    var gameViewController: GameViewController?
    
    //MARK : INITIALIZE
    override func didMove(to view: SKView) {
        switch gameStatus {
        case GameStatus.StandBy:
            initializeStandByComponents()
            initializePlayComponents()
            
            break
        case GameStatus.Play:
            break
        case GameStatus.GameOver:
            print("GameOver")
            break
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch gameStatus {
        case GameStatus.StandBy:
            break
        case GameStatus.Play:

            for enemyLetter in playComponents.activeEnemyLetter {
                if ((enemyLetter.position.y) - enemyLetter.size.height / 2) <= (playComponents.floorNode.size.height) {
                    enemyLetterTouchTheFloorExplode(enemyLetter: enemyLetter)
                }
                enemyLetter.runSmoke()
            }

            for torpedo in playComponents.activeTorpedo {
                
                
                for enemyLetter in playComponents.activeEnemyLetter {
                    
                    if torpedo.targetLetter?.type == enemyLetter.type {
                        if torpedo.position.y >= enemyLetter.position.y {
                            torpedoDidCollideWithAlien(torpedoNode: torpedo, enemyLetter: enemyLetter)
                        }
                    }
                    
                }
                
                let torpedoPosition = torpedo.size.height + torpedo.position.y
                if torpedoPosition > self.size.height {
                    if let torpedoIndex = playComponents.activeTorpedo.firstIndex(of: torpedo) {
                        playComponents.activeTorpedo.remove(at: torpedoIndex)
                    }
                    torpedo.removeFromParent()
                }
            }
            
            break
        case GameStatus.GameOver:

            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameStatus {
        case GameStatus.StandBy:
            print("StandBy")
            standByComponents.removeComponents(gameScene: self)
            break
        case GameStatus.Play:
            print("Play")
            break
        case GameStatus.GameOver:
            break
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameStatus {
        case GameStatus.StandBy:
            playButtonExplode()
            gameStatus = GameStatus.Play
            break
        case GameStatus.Play:
            break
        case GameStatus.GameOver:
            for touch in touches {
                let location = touch.location(in: self)
                let touchedNode = self.nodes(at: location)
                for node in touchedNode {

                    if node == gameOverComponents.quitNode {
                        gameOverComponents.removeComponents(gameScene: self)
                        playComponents.removeComponents(gameScene: self)
                        initializeStandByComponents()
                        initializePlayComponents()
                        gameStatus = GameStatus.StandBy
                    } else if node == gameOverComponents.gameOverPlayAgainButton {
                        gameOverComponents.removeComponents(gameScene: self)
                        playComponents.showAllComponents(scene: self)
                        playComponents.lifeNode.initializeLifeImages()
                        gameStatus = GameStatus.Play
                    } else {
                        print("NOTHING HAPPEN")
                    }
                }
            }
            break
        }
    }
}

