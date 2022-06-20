//
//  SocialAuthHelperProtocols.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 15/05/2021.
//

import UIKit

//MARK: SocialAuthDelegate
/**
 responsible for getting result of login with all available in success and failure.
 */
public protocol SocialAuthDelegate: AnyObject {
    /**
     responsible for getting result of login with all available in success case, with user model that given from logging and the permissions that accepted and declined from the login request.
     */
    func didAuthenticated(result: SocialUserModel,
                          grantedPermissions: [SocialPermissionsType]?,
                          declinedPermissions: [SocialPermissionsType]?)
    /**
     responsible for getting the error message of logging failure, in any stage of logging.
     */
    func didFailWith(error: String?)
}


extension SocialAuthDelegate {
    // default implementation for didAuthenticated as not all social logging return grantedPermissions or declinedPermissions.
    func didAuthenticated(result: SocialUserModel) {
        self.didAuthenticated(result: result,
                              grantedPermissions: [],
                              declinedPermissions: [])
    }
}

//MARK: SocialAuthHelper
/**
 responsible for launching login with social or logout from social.
 */
public protocol SocialAuthHelper {
    /**
     enable logging out from social account that already login with in app.
     */
    func logoutFromSocialAccount()
    
    /**
     enable launching logging with any available Social provider in appt.
     */
    func launchLoginWithSocial()
}
