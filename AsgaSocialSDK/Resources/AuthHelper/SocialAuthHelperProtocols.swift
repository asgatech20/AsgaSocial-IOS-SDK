//
//  SocialAuthHelperProtocols.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 15/05/2021.
//

import UIKit

//MARK: SocialAuthDelegate
public protocol SocialAuthDelegate: AnyObject {
    func didAuthenticated(result: SocialUserModel,
                          grantedPermissions: [SocialPermissionsType]?,
                          declinedPermissions: [SocialPermissionsType]?)
    func didFailWith(error: String?)
}

extension SocialAuthDelegate {
    func didAuthenticated(result: SocialUserModel) {
        self.didAuthenticated(result: result,
                              grantedPermissions: [],
                              declinedPermissions: [])
    }
}

//MARK: SocialAuthHelper
public protocol SocialAuthHelper {
    func logoutFromSocialAccount()
    func launchLoginWithSocial()
}
