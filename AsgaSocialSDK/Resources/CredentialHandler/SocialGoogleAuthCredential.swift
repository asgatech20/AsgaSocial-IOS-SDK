//
//  SocialGoogleAuthCredential.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 6/6/22.
//

import Foundation

//MARK: Google Credential Constants
/// Credentials That needed when login with Google
class SocialGoogleAuthCredential {
    //MARK: Variables
    
    /// Id needed to enable login with google, it should be set it's value in app delegate
    var googleClientID = ""

    static var shared: SocialGoogleAuthCredential = {
        let instance = SocialGoogleAuthCredential()
        return instance
    }()
    
    //MARK: Inner Functions
    private init() {}
}
