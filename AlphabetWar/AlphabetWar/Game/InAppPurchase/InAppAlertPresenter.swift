//
//  InAppAlertPresenter.swift
//  AlphabetWar
//
//  Created by Harry on 8/3/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import Foundation
import SwiftMessages

final class InAppAlertPresenter: NSObject, InAppAlertPresenterProtocol {

    private let awInAppAlertView = "AWInAppDialogView"

    public static var intance = InAppAlertPresenter()

    public var viewController: GameViewController?

    private override init() {
    }

    func showInAppAlert(viewController: GameViewController, handler: AlertHandler?) {
        self.viewController = viewController

        if let customAlertView = UINib(nibName: awInAppAlertView, bundle: nil).instantiate(withOwner: self, options: nil).first as? AWInAppDialogView {
            customAlertView.configure { action in
                handler?(action)
            }

            var config = SwiftMessages.Config()
            config.presentationStyle = .center
            config.duration = .forever
            config.interactiveHide = false

            SwiftMessages.show(config: config, view: customAlertView)
        }
    }

    func hideInAppAlert() {
        viewController?.goBackToStandByStatus()
        viewController = nil
        SwiftMessages.hide()
    }
}

