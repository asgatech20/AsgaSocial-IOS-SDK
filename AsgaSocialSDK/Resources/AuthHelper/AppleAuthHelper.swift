//
//  AppleAuthHelper.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 15/05/2021.
//

import Foundation
import AuthenticationServices

public class AppleAuthHelper: NSObject, SocialAuthHelper {
    //MARK: Variables
    var viewController: (UIViewController & SocialAuthDelegate)
    var permissions: [ASAuthorization.Scope]
    
    //MARK: Inner Functions
    public init(viewController: UIViewController & SocialAuthDelegate, permissions: [SocialPermissionsType]) {
        self.viewController = viewController
        self.permissions = (SocialPermissionsType.handlePermissions(permissions, providerType: .apple) as? [ASAuthorization.Scope]) ?? []
    }
    
    //MARK: Implemented Functions Of SocialAuthHelper
    public func logoutFromSocialAccount() {
        
    }
    
    public func launchLoginWithSocial() {
        let requestAppleID = ASAuthorizationAppleIDProvider().createRequest()
        requestAppleID.requestedScopes = permissions
        requestAppleID.requestedOperation = .operationImplicit
        let controller = ASAuthorizationController(authorizationRequests: [requestAppleID])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

//MARK: Apple Delegate Implementation Functions
extension AppleAuthHelper: ASAuthorizationControllerDelegate,
                           ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.keyWindow!
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        
        let userIdentifier = appleIDCredential.user
        let fullName = appleIDCredential.fullName
        let email = appleIDCredential.email
        
        let model = SocialUserModel(providerId: userIdentifier,
                                    fName: fullName?.givenName ?? "",
                                    lName: fullName?.familyName ?? "",
                                    image: "",
                                    email: email ?? "")
        viewController.didAuthenticated(result: model)
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        guard let error = error as? ASAuthorizationError else { return }
        switch error.code {
        case .canceled:
            print("You canceled login with apple")
        case .failed:
            print("failed login with apple")
            viewController.didFailWith(error: error.localizedDescription)
        default:
            print("unknown error login with apple")
            viewController.didFailWith(error: error.localizedDescription)
        }
    }
}
