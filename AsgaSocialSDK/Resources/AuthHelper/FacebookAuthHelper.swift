//
//  FacebookAuthHelper.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 15/05/2021.
//

import Foundation
import FacebookLogin
import FacebookCore

class FacebookAuthHelper: SocialAuthHelper {
    //MARK: Variables
    var viewController: (UIViewController & SocialAuthDelegate)
    var permissions: [String]
    var parameters: String
    let faceBookLoginManager = LoginManager()
    
    //MARK: Inner Functions
    public init(viewController: UIViewController & SocialAuthDelegate, permissions: [SocialPermissionsType]) {
        self.viewController = viewController
        self.permissions = (SocialPermissionsType.handlePermissions(
                                permissions,
                                providerType: .facebook) as? [String]) ?? []
        parameters = SocialPermissionsType.handleParameters(
                                        permissions,
                                        providerType: .facebook)
    }
    
    //MARK: Implemented Functions Of SocialAuthHelper
    public func logoutFromSocialAccount() {
        faceBookLoginManager.logOut()
    }
    
    /// handle requests to facebook SDK to login.
    func launchLoginWithSocial() {
        // first logout from any previous account to enabling login with any other account
        logoutFromSocialAccount()

        faceBookLoginManager.logIn(permissions: permissions, from: viewController) { [weak viewController] (result, error) in

            guard let token = result?.token else {
            #if DEBUG
                viewController?.didFailWith(error: error?.localizedDescription ?? "Check if Login with facebook is in Development Mode, if it's in development mode you need to make it live or add test users.")
            #else
                viewController?.didFailWith(error: error?.localizedDescription ?? "something went wrong, pls try again later")
            #endif
                return
            }

            let declinedPermTypes = result?.declinedPermissions.compactMap({SocialPermissionsType(rawValue: $0)})
            let grantedPermTypes = result?.grantedPermissions.compactMap({SocialPermissionsType(rawValue: $0)})
            self.requestParameters(ofToken: token, grantedPermissions: grantedPermTypes ?? [], declinedPermissions: declinedPermTypes ?? [])
        }
    }
    
    /// request parameters regard to permissions requested
    private func requestParameters(ofToken token: AccessToken,
                                   grantedPermissions: [SocialPermissionsType],
                                   declinedPermissions: [SocialPermissionsType]) {
        let request = getGraphRequest(ofToken: token.tokenString)
        
        request.start { _, result, error in
            guard error == nil else {
                self.viewController.didFailWith(error: error?.localizedDescription)
                return
            }
            self.handleResult(result, grantedPermissions: grantedPermissions, declinedPermissions: declinedPermissions)
        }
    }
    
    /// handle graph request object that responsible for requesting user account informations
    private func getGraphRequest(ofToken token: String) -> GraphRequest {
        GraphRequest(
            graphPath: "me",
            parameters: ["fields": self.parameters],
            tokenString: token,
            version: nil,
            httpMethod: .get
        )
    }
    
    /// handle result of requesting user account informations in success and failure
    private func handleResult(_ result: Any?,
                              grantedPermissions: [SocialPermissionsType],
                              declinedPermissions: [SocialPermissionsType]) {
        let response = result as?  [String: AnyObject]
        
        let id = response?["id"] as? String ?? ""
        let name = response?["name"] as? String ?? ""
        let fullNameArr = name.split {$0 == " "}
        let picture = response?["picture"] as? NSDictionary
        let picData = picture?["data"] as? NSDictionary
        let image = picData?["url"] as? String ?? ""
        let fName = fullNameArr[0]
        let lName = (fullNameArr.count > 1 ) ? fullNameArr[1] : ""
        let email = response?["email"] as? String ?? ""
        let birthday = response?["birthday"] as? String ?? ""
        let gender = response?["gender"] as? String ?? ""
        
        let model = SocialUserModel(
            providerId: id,
            fullName: name,
            fName: String(fName),
            lName: String(lName),
            image: image,
            email: email,
            gender: gender,
            birthdate: birthday,
            providerType: .facebook
        )
        viewController.didAuthenticated(result: model, grantedPermissions: grantedPermissions, declinedPermissions: declinedPermissions)
    }
}
