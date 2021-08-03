//
//  AWInAppDialogView.swift
//  AlphabetWar
//
//  Created by Harry on 8/3/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import UIKit

class AWInAppDialogView: UIView {

//    @IBOutlet private weak var titleLbl: UILabel!
//    @IBOutlet private weak var bodyLbl: UILabel!
//    @IBOutlet private weak var okBtn: UIButton!
//    @IBOutlet private weak var cancelBtn: UIButton!

    private var alertHandler: AlertHandler?

    func configure(handler: AlertHandler?) {
        alertHandler = handler
    }

//    @IBAction private func okButtonTapped(_ sender: Any) {
//        alertHandler?(.ok)
//    }
//
//    @IBAction private func cancelButtonTapped(_ sendel: Any) {
//        alertHandler?(.cancel)
//    }

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commonInit()
//    }
//
//    func commonInit() {
//        Bundle.main.loadNibNamed("AWInAppAlertView", owner: self, options: nil)
////        addSubview(contentView)
////        contentView.frame = self.bounds
////        contentView.autoresizeMask = [.flexibleHeight, .flexibleWidth]
//    }
}
