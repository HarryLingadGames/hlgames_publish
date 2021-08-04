//
//  AWInAppDialogView.swift
//  AlphabetWar
//
//  Created by Harry on 8/3/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import UIKit

struct ProductModel {
    let title: String?
    let handler: (() -> Void)
}

protocol AWInAppDialogViewDelegate {
    func goBackToStandByStatus()
}

class AWInAppDialogView: UIView {

    @IBOutlet private weak var life50Btn: UIButton!
    @IBOutlet private weak var life100Btn: UIButton!
    @IBOutlet private weak var life150Btn: UIButton!

    private var alertHandler: AlertHandler?
    var awInAppDialogViewDelegate: AWInAppDialogViewDelegate?

    var models = [ProductModel]()

    var myLifeCount: Int {
        let lifeCount = UserDefaults.standard.integer(forKey: "life_count")
        return lifeCount
    }

    func configure(handler: AlertHandler?) {
        alertHandler = handler

        models.append(ProductModel(title: "500 Life", handler: {
            IAPManager.shared.purchase(product: .life_500) { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.myLifeCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "life_count")
                    self?.hideInAppAlert()
                    self?.setUpHeader()
                }
            }
        }))

        models.append(ProductModel(title: "1000 Life", handler: {
            IAPManager.shared.purchase(product: .life_1000) { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.myLifeCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "life_count")
                    self?.hideInAppAlert()
                    self?.setUpHeader()
                }
            }
        }))

        models.append(ProductModel(title: "1500 Life", handler: {
            IAPManager.shared.purchase(product: .life_1500) { [weak self] count in
                DispatchQueue.main.async {
                    let currentCount = self?.myLifeCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "life_count")
                    self?.hideInAppAlert()
                    self?.setUpHeader()
                }
            }
        }))
    }

    @IBAction func life50Tapped(_ sender: Any) {
        print("Buy 50")
        models[0].handler()
    }

    @IBAction func life100Tapped(_ sender: Any) {
        print("Buy 100")
        models[1].handler()
    }

    @IBAction func life150Tapped(_ sender: Any) {
        print("Buy 150")
        models[2].handler()
    }

    func setUpHeader() {
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
//        let imageView = UIImageView(image: UIImage(named: "life_fire"))
//        imageView.frame = CGRect(x: (view.frame.size.width - 100)/2, y: 10, width: 100, height: 100)
//        header.addSubview(imageView)
//
//        let label = UILabel(frame: CGRect(x: 10, y: 120, width: view.frame.size.width - 20, height: 100))
//        label.textAlignment = .center
//        label.text = "\(myLifeCount) Lives"
//        label.font = .systemFont(ofSize: 25, weight: .bold)
//        header.addSubview(label)
//
//        tableView.tableHeaderView = header
    }

    func hideInAppAlert() {
        InAppAlertPresenter.intance.hideInAppAlert()
        awInAppDialogViewDelegate?.goBackToStandByStatus()
    }

}
