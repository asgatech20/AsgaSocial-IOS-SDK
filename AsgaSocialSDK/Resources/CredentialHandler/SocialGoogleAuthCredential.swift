//
//  SocialGoogleAuthCredential.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 6/6/22.
//

import Foundation

//MARK: Google Credential Constants
/// Credentials That needed when login with Google
public class SocialGoogleAuthCredential {
    //MARK: Variables
    
    /// Id needed to enable login with google, it should be set it's value in app delegate
    public var googleClientID = ""

    public static var shared: SocialGoogleAuthCredential = {
        let instance = SocialGoogleAuthCredential()
        return instance
    }()
    
    //MARK: Inner Functions
    private init() {}
}
