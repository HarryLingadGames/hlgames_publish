//
//  AWGamePlayComponents.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 1/31/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class AWGamePlayComponents: NSObject, PlayComponentProtocol {

    var level: Int = 1
    let defaults = UserDefaults.standard
    var lifeNode: LifeNode!

    var starfield:SKEmitterNode!
    
    var recordNode: ScoreNode!
    
    var gameTimer:Timer!
    
    var floorNode: ButtonsSKNode!
    
    var enemyLetterNames = [LetterType.a,
                            LetterType.b,
                            LetterType.c,
                            LetterType.d,
                            LetterType.e,
                            LetterType.f,
                            LetterType.g,
                            LetterType.h,
                            LetterType.i,
                            LetterType.j,
                            LetterType.k,
                            LetterType.l,
                            LetterType.m,
                            LetterType.n,
                            LetterType.o,
                            LetterType.p,
                            LetterType.q,
                            LetterType.r,
                            LetterType.s,
                            LetterType.t,
                            LetterType.v,
                            LetterType.x,
                            LetterType.y,
                            LetterType.z]
    
    var activeEnemyLetter = [EnemyLetterNode]()
    var activeTorpedo = [TorpedoNode]()
    
    
    let enemyLetterCategory:UInt32 = 0x1 << 1
    let photonTorpedoCategory:UInt32 = 0x1 << 0
    
    let motionManger = CMMotionManager()
    var xAcceleration:CGFloat = 0

    var scene: GameScene = GameScene()
    var gameViewController: GameViewController?
    
    override init() {
        super.init()
    }

    init(gameScene: GameScene){
        super.init()

        //MARK: - TEMP
        scene = gameScene
        gameViewController = scene.gameViewController
        gameViewController?.playComponentDelegate = self
        scene.gameViewController?.gameDelegate = scene

        setUpLetterButtons(scene: gameScene)
        setUpActiveEnemyLetter(scene: gameScene)
        setUpStarField(scene: gameScene)
        setUpRecordNode(scene: gameScene)
        setUpLifeNode(scene: gameScene)
        setUpPhysicsWorld(scene: gameScene)
        setUpMotionManager(scene: gameScene)
        setUpGameTime(scene: gameScene)
        hideAllComponents(gameScene: gameScene)
    }

    func removeComponents(gameScene: GameScene){
        gameScene.removeAllChildren()
    }
    
    func hideAllComponents(gameScene: GameScene){
        
        if gameTimer != nil{
            gameTimer.invalidate()
        }
        
        for enemy in activeEnemyLetter{
            enemy.remove()
        }

        recordNode.hide(scene: scene)
        floorNode.run(SKAction.move(to: CGPoint(x: 0, y: -floorNode.size.height), duration: 0.3))
        lifeNode.run(SKAction.move(to: lifeNode.oldPosition(scene: scene), duration: 0.3))
        
    }
    
    func showAllComponents(scene: GameScene){
        gameTimer = Timer.scheduledTimer(timeInterval: TimeInterval(GameDimension.TIME_ENEMY_WILL_APPEAR), target: scene, selector: #selector(scene.addEnemyLetter), userInfo: nil, repeats: true)
        floorNode.zPosition = 1
        level = 1

        activeEnemyLetter.removeAll()
        recordNode.show(scene: scene)
        lifeNode.run(SKAction.move(to: lifeNode.newPosition(scene: scene), duration: 0.3))
        floorNode.run(SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.5))

        setUpKeyboard(scene: scene)
    }

    private func setUpLetterButtons(scene: GameScene) {
        floorNode = ButtonsSKNode(gameScene: scene, color: UIColor.systemBlue, size: CGSize(width: scene.size.width, height: scene.size.width))
        floorNode.anchorPoint = GameDimension.ANCHOR_POINTS
        floorNode.position = CGPoint(x: 0, y: -floorNode.size.height)
        floorNode.isHidden = true
        scene.addChild(floorNode)
    }

    private func setUpActiveEnemyLetter(scene: GameScene) {
        activeEnemyLetter = [EnemyLetterNode]()
    }

    private func setUpStarField(scene: GameScene) {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: scene.size.height)
        starfield.particlePositionRange = CGVector(dx: scene.size.width * 2, dy: scene.size.height)
        starfield.advanceSimulationTime(10)
        scene.addChild(starfield)
        starfield.zPosition = -1
    }
    
    private func setUpRecordNode(scene: GameScene) {
        recordNode = ScoreNode(scene: scene)
        scene.addChild(recordNode)
    }

    func setUpLifeNode(scene: GameScene) {
        lifeNode = LifeNode(scene: scene)
        scene.addChild(lifeNode)
    }

    private func setUpPhysicsWorld(scene: GameScene) {
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        scene.physicsWorld.contactDelegate = scene
    }

    private func setUpMotionManager(scene: GameScene) {
        motionManger.accelerometerUpdateInterval = 0.2
        motionManger.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                scene.xAcceleration = CGFloat(acceleration.x) * 0.75 + scene.xAcceleration * 0.25
            }
        }
    }

    private func setUpGameTime(scene: GameScene) {
        gameTimer = Timer()
    }

    func setUpKeyboard(scene: GameScene) {
        scene.keyBoardDelegate?.showKeyboard()
    }

    func setKeyboardHeight(height: CGFloat) {
        floorNode.size = CGSize(width: scene.size.width, height: height)
    }

    func updateKeyboardHeight(height: CGFloat) {
        floorNode.run(SKAction.resize(toHeight: height, duration: 0.1))
    }
}

