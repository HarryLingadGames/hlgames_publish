//
//  GameViewController.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 1/31/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

//Privacy and Policy Link: https://www.privacypolicies.com/live/748aa9e1-3590-4911-88b3-cba5f5aab0a6

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds
import FBAudienceNetwork
import AdSupport
//import StoreKit

protocol GameViewControllerProtocol {
    func fireTorpedo(type: LetterType)
    func gotoBackGround()
}

protocol GameNavigationProtocol {
    func goToInAppPurchase()
}

protocol PlayComponentProtocol {
    func setKeyboardHeight(height: CGFloat)
    func updateKeyboardHeight(height: CGFloat)
}

protocol GameSceneProtocol {
    func setShouldDisplayAdToFalse()
}

class GameViewController: UIViewController, KeyBoardProtocol, UITextFieldDelegate {
    
    var awTextField: UITextField = UITextField()
    var gameDelegate: GameViewControllerProtocol?
    var playComponentDelegate: PlayComponentProtocol?
    var gameSceneProtocol: GameSceneProtocol?
    var navigationProtocol: GameNavigationProtocol?
    var isKeyBoardShown: Bool = false
    
    var interstitial: GADInterstitialAd?
    var fbInterstitialAd: FBInterstitialAd?
    var isAdOpen: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

//        createAdMob()
        print("IDFA: \(String(describing: identifierForAdvertising()))")
        createAudienceNetwork()

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)

        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.gameViewController = self
                sceneNode.keyBoardDelegate = self
                sceneNode.navigationDelegate = self
                sceneNode.size.width = self.view.frame.width
                sceneNode.size.height = (self.view.frame.width * GameDimension.TARGET_GAMESCREEN_HEIGHT) / GameDimension.TARGET_GAMESCREEN_WIDTH
                
                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
//
                // Set the scale mode to scale to fit the window
//                sceneNode.scaleMode = .aspectFill
//                sceneNode.scaleMode = .fill
                sceneNode.scaleMode = .resizeFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
        setUpKeyboard()
    }

    func createAudienceNetwork() {
        fbInterstitialAd = FBInterstitialAd(placementID: AdCodes.AudienceNetwor.rawValue)
        fbInterstitialAd?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        awTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(changeKeyboardType), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }

    @objc func changeKeyboardType(notification: NSNotification) {

        if let keyBoardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            playComponentDelegate?.updateKeyboardHeight(height: keyBoardSize.height)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func setUpKeyboard() {
        awTextField.autocapitalizationType = .none
        awTextField.autocorrectionType = .no
        awTextField.keyboardType = .asciiCapable

        awTextField.sizeThatFits(CGSize(width: 0, height: 0))
        self.view.addSubview(awTextField)
    }

    func showKeyboard() {
        awTextField.becomeFirstResponder()
    }

    func hideKeyBoard() {
        awTextField.resignFirstResponder()
        isKeyBoardShown = false
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyBoardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, !isKeyBoardShown {
            playComponentDelegate?.setKeyboardHeight(height: keyBoardSize.height)
            isKeyBoardShown = true
        }
    }

    @objc func appMovedToBackground() {
        gameDelegate?.gotoBackGround()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        awTextField.text = ""
        gameDelegate?.fireTorpedo(type: LetterType.getType(stringLetter: string))
        return true
    }
    
//    func openRateMe() {
//        guard let scene = view.window?.windowScene else {
//            debugPrint("scene is nil")
//            return
//        }
//        
//        if #available(iOS 14.0, *) {
//            SKStoreReviewController.requestReview(in: scene)
//        } else {
//            SKStoreReviewController.requestReview()
//        }
//    }
}