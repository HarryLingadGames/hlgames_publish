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
}

protocol GameSceneNavigationProtocol {
    func goToInAppPurchaseScreen()
}

class GameScene: SKScene, SKPhysicsContactDelegate, GameSceneProtocol {
    
    var xAcceleration:CGFloat = 0
    var playComponents: AWGamePlayComponents!
    var standByComponents: AWGameStandByComponents!
    var gameOverComponents: AWGameGameOverComponents!
    
    var gameStatus: GameStatus = GameStatus.StandBy
    var enemyCounter: Int = 0

    var keyBoardDelegate: KeyBoardProtocol?
    var navigationDelegate: GameSceneNavigationProtocol?

    var gameViewController: GameViewController?

    var shouldOpenAd: Bool = false
    
    //MARK : INITIALIZE
    override func didMove(to view: SKView) {
        gameViewController?.gameSceneProtocol = self
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
        case GameStatus.InAppPurchase:
            print("InApp Purchase")
            break
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch gameStatus {
        case GameStatus.StandBy:
            break
        case GameStatus.Play:

            let _ = playComponents.activeEnemyLetter.map {
                if (($0.position.y) - $0.size.height / 2) <= (playComponents.floorNode.size.height) {
                    enemyLetterTouchTheFloorExplode(enemyLetter: $0)
                }
                $0.runSmoke()
            }

            for torpedo in playComponents.activeTorpedo {
                let _ = playComponents.activeEnemyLetter.map {
                    if torpedo.targetLetter?.type == $0.type {
                        if torpedo.position.y >= $0.position.y {
                            torpedoDidCollideWithAlien(torpedoNode: torpedo, enemyLetter: $0)
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
        case GameStatus.InAppPurchase:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameStatus {
        case GameStatus.StandBy:
            print("StandBy")
            break
        case GameStatus.Play:
            print("Play")
            break
        case GameStatus.GameOver:
            break
        case GameStatus.InAppPurchase:
            break
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameStatus {
        case GameStatus.StandBy:
            for touch in touches {
                let location = touch.location(in: self)
                let touchedNode = self.nodes(at: location)
                for node in touchedNode {
                    if node == standByComponents.gameStandbyPlayButton {
                        playButtonExplode()
                        gameStatus = GameStatus.Play
                    } else if node == standByComponents.buyLifeButton {
                        gameStatus = GameStatus.InAppPurchase
                        navigationDelegate?.goToInAppPurchaseScreen()
                    }
                }
            }

            standByComponents.removeComponents(gameScene: self)
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
                        if !shouldOpenAd {
                            gameOverComponents.removeComponents(gameScene: self)
                            playComponents.showAllComponents(scene: self)
                            playComponents.lifeNode.initializeLifeImages()
                            gameStatus = GameStatus.Play
                        }
                    } else {
                        print("NOTHING HAPPEN")
                    }
                }
            }
            break
        case GameStatus.InAppPurchase:
            break
        }
    }

    func setShouldDisplayAdToFalse() {
        shouldOpenAd = false
    }


    func goBackToStandByStatus() {
        initializeStandByComponents()
        initializePlayComponents()
        gameStatus = GameStatus.StandBy
    }

//    func goBackToStandByStatus(numLife: Int) {
//        initializeStandByComponents()
//        initializePlayComponents()
//        gameStatus = GameStatus.StandBy
//    }
}

