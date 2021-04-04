//
//  GameViewController+AudienceNetwork.swift
//  AlphabetWar
//
//  Created by Harry on 4/1/21.
//  Copyright © 2021 HL Games. All rights reserved.
//

import Foundation
import UIKit
import FBAudienceNetwork
import AdSupport



extension GameViewController: FBInterstitialAdDelegate {

    //Hash: b602d594afd2b0b327e07a06f36ca6a7e42546d0
    //For 771308210172928_771317576838658



    func openAudienceNetwork() {
        if !isAdOpen {
            fbInterstitialAd?.load()
        }
    }

    func interstitialAd(_ interstitialAd: FBInterstitialAd, didFailWithError error: Error) {
        print("AUDIENCE NETWORK ERROR: \(error.localizedDescription)")
    }

    func interstitialAdDidLoad(_ interstitialAd: FBInterstitialAd) {
        fbInterstitialAd?.show(fromRootViewController: self)
        isAdOpen = true
    }

    //MARK: - AN ADSUPPORT

    func identifierForAdvertising() -> String? {
        // Check whether advertising tracking is enabled
        guard ASIdentifierManager.shared().isAdvertisingTrackingEnabled else {
            return nil
        }

        // Get and return IDFA
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }


    func interstitialAdDidClick(_ interstitialAd: FBInterstitialAd) {
        debugPrint("Audience Network: Dic Click")
    }

    func interstitialAdDidClose(_ interstitialAd: FBInterstitialAd) {
        debugPrint("Audience Network: Did Closed")
        createAudienceNetwork()
        isAdOpen = false
        gameSceneProtocol?.setShouldDisplayAdToFalse()
    }

    func interstitialAdWillClose(_ interstitialAd: FBInterstitialAd) {
        debugPrint("Audience Network: Will Close")
    }

    func interstitialAdWillLogImpression(_ interstitialAd: FBInterstitialAd) {
        debugPrint("Audience Network: Will Log Impression")
    }




}
