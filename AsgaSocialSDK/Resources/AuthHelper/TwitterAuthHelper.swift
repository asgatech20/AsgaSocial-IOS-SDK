//
//  TwitterAuthHelper.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 15/05/2021.
//

import Foundation
import Swifter

public class TwitterAuthHelper: SocialAuthHelper {
    //MARK: Variables
    var viewController: (UIViewController & SocialAuthDelegate)
    let swifterObj = Swifter(consumerKey: SocialTwitterAuthCredential.shared.twitterConsumerKey,
                          consumerSecret: SocialTwitterAuthCredential.shared.twitterConsumerSecret)
    
    //MARK: Inner Functions
    public init(viewController: UIViewController & SocialAuthDelegate) {
        self.viewController = viewController
    }
    
    //MARK: Implemented Functions Of SocialAuthHelper
    public func logoutFromSocialAccount() {
        
    }
    
    ///
    public func launchLoginWithSocial() {
        guard let callbackUrl = URL(string: SocialTwitterAuthCredential.shared.twitterAuthCallBackUrl) else { return }
        
        swifterObj.authorize(withCallback: callbackUrl, presentingFrom: viewController, success: { (accessToken, response) in
            guard let providerId = accessToken?.userID else {
                return
            }
            self.swifterObj.verifyAccountCredentials(includeEntities: false, skipStatus: false, includeEmail: true, success: { (json) in
                
                self.handleResponse(withJson: json, id: providerId)
            }) { (error) in
                self.viewController.didFailWith(error: error.localizedDescription)
            }
        })
    }
    
    private func handleResponse(withJson json: JSON, id: String) {
        let email = json["email"].string ?? ""
        let profileImage = json["profile_image_url_https"].string  ?? ""
        let name = json["name"].string  ?? ""
        
        let fullNameArr = name.split{$0 == " "}
        let fName = String(fullNameArr[0])
        let lName = String((fullNameArr.count > 1 ) ? fullNameArr[1] : "" )
        
        let model = SocialUserModel(providerId: id,
                                    fullName: name,
                                    fName: fName,
                                    lName: lName,
                                    image: profileImage,
                                    email: email)
        self.viewController.didAuthenticated(result: model)
    }
}
