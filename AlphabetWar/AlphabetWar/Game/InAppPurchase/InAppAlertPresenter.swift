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

    private override init() {
    }

    func showAlert(title: String, body: String, okButtonTitle: String, cancelButtonTitle: String, handler: AlertHandler?) {

//        if let customAlertView = UINib(nibName: awInAppAlertView, bundle: nil).instantiate(withOwner: self, options: nil).first as? AWInAppAlertView {
//            customAlertView.configure(title: title, body: body, okTitle: okButtonTitle, cancelTitle: cancelButtonTitle) { action in
//                SwiftMessages.hide()
//                handler?(action)
//            }
//
//            var config = SwiftMessages.Config()
//            config.presentationStyle = .center
//            config.duration = .forever
//            config.interactiveHide = false
////            config.dimMode = .blur(style: .dark, alpha: 0.5, interactive: true)
//
//            SwiftMessages.show(config: config, view: customAlertView)
//        }
    }

    func showInAppAlert(handler: AlertHandler?) {
        if let customAlertView = UINib(nibName: awInAppAlertView, bundle: nil).instantiate(withOwner: self, options: nil).first as? AWInAppDialogView {
            customAlertView.configure { action in
                SwiftMessages.hide()
                handler?(action)
            }

            var config = SwiftMessages.Config()
            config.presentationStyle = .center
            config.duration = .forever
            config.interactiveHide = false

            SwiftMessages.show(config: config, view: customAlertView)
        }
    }




}

