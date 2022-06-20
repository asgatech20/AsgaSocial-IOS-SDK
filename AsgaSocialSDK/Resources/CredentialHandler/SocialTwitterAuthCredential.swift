//
//  SocialAuthManager.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 15/05/2021.
//

import Foundation

//MARK: Twitter Credential Constants
/// Credentials That needed when login with Twitter, it's variables should be set it's value in app delegate
public class SocialTwitterAuthCredential {
    //MARK: Variables
    public var twitterConsumerKey = ""
    public var twitterConsumerSecret = ""
    public var twitterAuthCallBackUrl = ""
    
    public static var shared: SocialTwitterAuthCredential = {
        let instance = SocialTwitterAuthCredential()
        return instance
    }()
    
    //MARK: Inner Functions
    private init() {}
}
