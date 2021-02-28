//
//  SplashScreenViewController.swift
//  AlphabetWar
//
//  Created by Harry Lingad on 2/28/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import Foundation
import UIKit


class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.performSegue(withIdentifier: "goToGameScreen", sender: nil)
        }
    }
    
    @IBAction func gotoGameScreen(_ sender: Any) {
        performSegue(withIdentifier: "goToGameScreen", sender: nil)
    }
    
}
