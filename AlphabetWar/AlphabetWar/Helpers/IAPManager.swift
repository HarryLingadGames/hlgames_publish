//
//  IAPManager.swift
//  AlphabetWar
//
//  Created by Harry on 7/21/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import Foundation
import StoreKit

final class IAPManager: NSObject, SKPaymentTransactionObserver, SKProductsRequestDelegate {

    static let shared = IAPManager()

    var products = [SKProduct]()

    public var completion: ((Int) -> Void)?

    enum Product: String {
        case life_500 = "com.harrylingadgames.AlphabetWar.50Life"
        case life_1000 = "com.harrylingadgames.AlphabetWar.100Life"
        case life_1500 = "com.harrylingadgames.AlphabetWar.150Life"

        var count: Int {
            switch self {
            case .life_500:
                return 50
            case .life_1000:
                return 100
            case .life_1500:
                return 150
            }
        }
    }

    public func fetchProduct() {

        let allProducts = ["com.harrylingadgames.AlphabetWar.50Life",
                           "com.harrylingadgames.AlphabetWar.100Life",
                           "com.harrylingadgames.AlphabetWar.150Life"]

        let request = SKProductsRequest(productIdentifiers: Set(allProducts))
        request.delegate = self
        request.start()
    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products

        let _ = self.products.map {
            print("Product Identifier: \($0.productIdentifier)")
        }
    }

    public func purchase(product: Product, completion: @escaping ((Int) -> Void)) {
        guard SKPaymentQueue.canMakePayments() else {
            return
        }

        guard let storeKitProduct = products.first(where: { $0.productIdentifier == product.rawValue }) else {
            return
        }

        self.completion = completion

        let paymentRequest = SKPayment(product: storeKitProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(paymentRequest)
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

        transactions.forEach({
            switch $0.transactionState {

            case .purchasing:
                break
            case .purchased:
                if let product = Product(rawValue: $0.payment.productIdentifier) {
                    completion?(product.count)
                }
                SKPaymentQueue.default().finishTransaction($0)
                SKPaymentQueue.default().remove(self)
                break
            case .failed:
                break
            case .restored:
                break
            case .deferred:
                break
            @unknown default:
                break
            }
        })
    }

}


