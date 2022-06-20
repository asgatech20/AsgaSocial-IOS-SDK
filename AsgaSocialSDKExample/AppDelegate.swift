//
//  AppDelegate.swift
//  AsgaSocialSDKExample
//
//  Created by Zinab Ahmed on 6/7/22.
//

import UIKit
import AsgaSocialSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SocialGoogleAuthCredential.shared.googleClientID = "googleClientID"
        SocialTwitterAuthCredential.shared.twitterConsumerSecret = "twitterConsumerSecret"
        SocialTwitterAuthCredential.shared.twitterAuthCallBackUrl = "twitterAuthCallBackUrl"
        SocialTwitterAuthCredential.shared.twitterConsumerKey = "twitterConsumerKey"
        return true
    }
}

