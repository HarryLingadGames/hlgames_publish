//
//  GameViewController+Delegate.swift
//  AlphabetWar
//
//  Created by Harry on 7/19/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController: GameSceneNavigationProtocol {
    func goToInAppPurchaseScreen() {

        print("Buy Life")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let inAppVC = storyBoard.instantiateViewController(withIdentifier: "InAppPurchaseViewController") as! InAppPurchaseViewController
        self.present(inAppVC, animated:true, completion:nil)
    }
}
