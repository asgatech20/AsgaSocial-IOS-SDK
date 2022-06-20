//
//  SocialHelper.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 5/31/22.
//

import UIKit

/// This Class enables to launch all Social Authentication provided in This SDK
public class SocialHelper {
    //MARK: Variables
    /// The  view controller that needs to handle login with social and will implements the delegate login functions.
    var viewController: UIViewController & SocialAuthDelegate
    
    /// The permissions that will request from the user of social account, they should be declared according to app needed
    var permissions: [SocialPermissionsType]
    
    //MARK: Inner Functions
    /**
     enable to <#usage#>
     - Parameters:
        - viewController: The  view controller that needs to handle login with social and will implements the delegate login functions.
        - permissions: The permissions type that will requested from the user of social account, they should be declared according to app needed
     */
    public init(viewController: UIViewController & SocialAuthDelegate, permissions: [SocialPermissionsType]) {
        self.viewController = viewController
        self.permissions = permissions
    }
    
    //MARK: Facebook Launcher
    /**
     responsible for login with facebook, request the permissions that set while initializing then request user account information from SDK
     */
    public func launchFacebookLogin() {
        let facebookAuthHelper: SocialAuthHelper = FacebookAuthHelper(
                                                        viewController: viewController,
                                                        permissions: permissions)
        facebookAuthHelper.launchLoginWithSocial()
    }
    
    //MARK: Google Launcher
    /**
     responsible for login with google using credential (googleClientID) which should be set in app delegate
     */
    public func launchGoogleLogin() {
        let googleAuthHelper: SocialAuthHelper = GoogleAuthHelper(viewController: viewController)
        googleAuthHelper.launchLoginWithSocial()
    }
    
    //MARK: Twitter Launcher
    /**
     responsible for login with twitter, request the authorizations then verify Account Credentials to enable
     */
    public func launchTwitterLogin() {
        let twitterAuthHelper: SocialAuthHelper = TwitterAuthHelper(viewController: viewController)
        twitterAuthHelper.launchLoginWithSocial()
    }
    
    //MARK: Apple Launcher
    /**
     responsible for login with facebook, request the permissions that set while initializing then request user account information from SDK
     */
    public func launchAppleLogin() {
//        let appleAuthHelper: SocialAuthHelper = AppleAuthHelper(viewController: viewController, permissions: permissions)
//        appleAuthHelper.launchLoginWithSocial()
    }
}
