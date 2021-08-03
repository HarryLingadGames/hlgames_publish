//
//  AWInAppDialogView.swift
//  AlphabetWar
//
//  Created by Harry on 8/3/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import UIKit

class AWInAppDialogView: UIView {

    @IBOutlet private weak var life50Btn: UIButton!
    @IBOutlet private weak var life100Btn: UIButton!
    @IBOutlet private weak var life150Btn: UIButton!

    private var alertHandler: AlertHandler?

    func configure(handler: AlertHandler?) {
        alertHandler = handler
    }

    @IBAction func life50Tapped(_ sender: Any) {
        print("Buy 50")
    }

    @IBAction func life100Tapped(_ sender: Any) {
        print("Buy 100")
    }

    @IBAction func life150Tapped(_ sender: Any) {
        print("Buy 150")
    }

}
