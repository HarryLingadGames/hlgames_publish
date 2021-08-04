//
//  InAppPurchaseViewController.swift
//  AlphabetWar
//
//  Created by Harry on 7/13/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

//import Foundation
//import UIKit
//import SwiftEntryKit
//
//struct ProductModel {
//    let title: String?
//    let handler: (() -> Void)
//}
//
//class InAppPurchaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }()
//
//    var models = [ProductModel]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        models.append(ProductModel(title: "500 Life", handler: {
//            IAPManager.shared.purchase(product: .life_500) { [weak self] count in
//                DispatchQueue.main.async {
//                    let currentCount = self?.myLifeCount ?? 0
//                    let newCount = currentCount + count
//                    UserDefaults.standard.setValue(newCount, forKey: "life_count")
//                    self?.setUpHeader()
//                }
//            }
//        }))
//
//        models.append(ProductModel(title: "1000 Life", handler: {
//            IAPManager.shared.purchase(product: .life_1000) { [weak self] count in
//                DispatchQueue.main.async {
//                    let currentCount = self?.myLifeCount ?? 0
//                    let newCount = currentCount + count
//                    UserDefaults.standard.setValue(newCount, forKey: "life_count")
//                    self?.setUpHeader()
//                }
//            }
//        }))
//
//        models.append(ProductModel(title: "1500 Life", handler: {
//            IAPManager.shared.purchase(product: .life_1500) { [weak self] count in
//                DispatchQueue.main.async {
//                    let currentCount = self?.myLifeCount ?? 0
//                    let newCount = currentCount + count
//                    UserDefaults.standard.setValue(newCount, forKey: "life_count")
//                    self?.setUpHeader()
//                }
//            }
//        }))
//
//        view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.frame = view.bounds
//        setUpHeader()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return models.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let model = models[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = model.title
//        cell.imageView?.image = UIImage(named: "life_fire")
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        tableView.deselectRow(at: indexPath, animated: true)
////        models[indexPath.row].handler()
//        goToInAppAlertView2()
//    }
//
//    var myLifeCount: Int {
//        let lifeCount = UserDefaults.standard.integer(forKey: "life_count")
//        return lifeCount
//    }
//
//    func setUpHeader() {
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
//    }
//
//    func goToInAppAlertView() {
//
//        let sampleView = UIView(frame: self.view.bounds)
//        sampleView.backgroundColor = .systemGreen
//
////        let customView = AWInAppAlertView()
//        var attributes = EKAttributes()
//        attributes.position = .bottom
//
//
//        SwiftEntryKit.display(entry: sampleView, using: attributes)
//    }
//
//    func goToInAppAlertView2() {
//        var attributes = EKAttributes()
//        attributes = .topFloat
//        attributes.displayDuration = 3
//        attributes.positionConstraints.size = .init(width: .offset(value: 0), height: .intrinsic)
//        let edgeWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
//        attributes.positionConstraints.maxSize = .init(width: .constant(value: edgeWidth),
//                                                                           height: .offset(value: 206))
//        attributes.positionConstraints.verticalOffset = .init(30)
//
//        let sampleView = UIView(frame: self.view.bounds)
//        sampleView.backgroundColor = .systemGreen
//
//        SwiftEntryKit.display(entry: sampleView,
//                              using: attributes)
//    }
//
//
//}
//
//
