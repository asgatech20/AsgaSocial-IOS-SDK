//
//  GoogleAuthHelper.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 15/05/2021.
//

import UIKit
import GoogleSignIn

public class GoogleAuthHelper: SocialAuthHelper {
    //MARK: Variables
    var viewController: (UIViewController & SocialAuthDelegate)
    
    //MARK: Inner Functions
    public init(viewController: UIViewController & SocialAuthDelegate) {
        self.viewController = viewController
    }
    
    //MARK: Implemented Functions Of SocialAuthHelper
    public func logoutFromSocialAccount() {
        GIDSignIn.sharedInstance.signOut()
    }
    
    /// handle logging with google requests to get user account information
    public func launchLoginWithSocial() {
        let configurations = GIDConfiguration(clientID: SocialGoogleAuthCredential.shared.googleClientID, serverClientID: nil, hostedDomain: nil, openIDRealm: nil)

        // first logout from any previous account to enabling login with any other account
        logoutFromSocialAccount()
        
        GIDSignIn.sharedInstance.signIn(with: configurations, presenting: viewController, hint: nil) { [weak viewController] googleUser, error in
           
            if let error = error {
                viewController?.didFailWith(error: error.localizedDescription)
            } else if let googleUser = googleUser, let id = googleUser.userID {
                self.handleResponse(withUser: googleUser, id: id)
            } else {
                viewController?.didFailWith(error: nil)
            }
        }
    }
    
    /// parse result of requesting user account informations in success case
    private func handleResponse(withUser user: GIDGoogleUser, id: String) {
        let fullName = user.profile?.name ?? ""
        let firstName = user.profile?.givenName ?? ""
        let lastName = user.profile?.familyName ?? ""
        let email = user.profile?.email ?? ""
        let image = user.profile?.imageURL(withDimension: UInt(round(100 * UIScreen.main.scale)))?.absoluteString ?? ""

        let model = SocialUserModel(providerId: id,
                                    fullName: fullName,
                                    fName: firstName,
                                    lName: lastName,
                                    image: image,
                                    email: email,
                                    providerType: .google)
        viewController.didAuthenticated(result: model)
    }
}
