//
//  GameViewController+Delegate.swift
//  AlphabetWar
//
//  Created by Harry on 7/19/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import Foundation
import UIKit
import SwiftEntryKit

extension GameViewController: GameSceneNavigationProtocol {
    func goToInAppPurchaseScreen() {
//        goToInAppPurchaseViewController()
        goToInAppAlertView()
    }

    func goToInAppAlertView() {

        InAppAlertPresenter.intance.showInAppAlert {_ in
            print("OK")
        }
    }


    func goToInAppPurchaseViewController() {
        print("Buy Life")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let inAppVC = storyBoard.instantiateViewController(withIdentifier: "InAppPurchaseViewController") as! InAppPurchaseViewController
        self.present(inAppVC, animated:true, completion:nil)
    }
}
