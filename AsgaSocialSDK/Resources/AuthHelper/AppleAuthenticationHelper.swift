//
//  AppleAuthenticationHelper.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 6/20/22.
//

import Foundation
import AuthenticationServices

@available(iOS 13.0, *)
open class AppleAuthenticationHelper: NSObject {
    //MARK: Variables
    
    /// Window act as the anchor for the authorization presentation.
    let window: UIWindow = UIApplication.shared.keyWindow!
    
    /// The permissions that will request from the user of social account, they should be declared according to app needed
    var permissions: [ASAuthorization.Scope]
    
    /// The  view controller that needs to handle login with social and will implements the delegate login functions.
    public weak var viewController: (UIViewController & SocialAuthDelegate)?

    public init(vc: UIViewController & SocialAuthDelegate, permissions: [SocialPermissionsType]) {
        self.viewController = vc
        self.permissions = (SocialPermissionsType.handlePermissions(permissions, providerType: .apple) as? [ASAuthorization.Scope]) ?? []
    }
    
    /// handle logging with Apple requests to get user account information
    public func launchAppleLogin() {
        let requestAppleID = ASAuthorizationAppleIDProvider().createRequest()
        requestAppleID.requestedScopes = permissions
        requestAppleID.requestedOperation = .operationImplicit
        let controller = ASAuthorizationController(authorizationRequests: [requestAppleID])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

// MARK: Login with Apple Delegates Implementations
@available(iOS 13.0, *)
extension AppleAuthenticationHelper:
    ASAuthorizationControllerDelegate,
    ASAuthorizationControllerPresentationContextProviding
{
    ///Tells the delegate from which window it should present content to the user.
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return window
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
        viewController?.didAuthenticated(result: model)
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        guard let error = error as? ASAuthorizationError else { return }
        switch error.code {
        case .canceled:
            print("You canceled login with apple")
        case .failed:
            print("failed login with apple")
            viewController?.didFailWith(error: error.localizedDescription)
        default:
            print("unknown error login with apple")
            viewController?.didFailWith(error: error.localizedDescription)
        }
    }
}
