//
//  InAppAlertPresenterProtocol.swift
//  AlphabetWar
//
//  Created by Harry on 8/3/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import Foundation

typealias AlertHandler = ((InAppAlertActionType) -> Void)

protocol InAppAlertPresenterProtocol {
    func showAlert(title: String, body: String, okButtonTitle: String, cancelButtonTitle: String, handler: AlertHandler?)
    func showInAppAlert(handler: AlertHandler?)
}
