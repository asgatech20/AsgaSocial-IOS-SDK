//
//  ViewController.swift
//  AsgaSocialSDKExample
//
//  Created by Zinab Ahmed on 6/7/22.
//

import UIKit
import AsgaSocialSDK

@available(iOS 13.0, *)
class ViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var appleButton: UIButton!
    
    //MARK: Variables
    lazy var permissions: [SocialPermissionsType] = [.publicProfile,
                                                   .email]
    lazy var socialAuthHelper = SocialHelper.init(
                                            viewController: self,
                                            permissions: permissions)

    lazy var appleAuthHelper = AppleAuthenticationHelper(vc: self, permissions: permissions)
    
    //MARK: Inner Function
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: Social Button Actions
    @IBAction func appleTapAction(_ sender: Any) {
        if #available(iOS 13.0, *) {
            appleAuthHelper.launchAppleLogin()
        } else {
            appleButton.isHidden = true
        }
    }
    
    @IBAction func facebookTapAction(_ sender: Any) {
        socialAuthHelper.launchFacebookLogin()
    }
    
    @IBAction func googleTapAction(_ sender: Any) {
        socialAuthHelper.launchGoogleLogin()
    }
    
    @IBAction func twitterTapAction(_ sender: Any) {
        socialAuthHelper.launchTwitterLogin()
    }
}

// MARK: SocialAuth Delegate
@available(iOS 13.0, *)
extension ViewController: SocialAuthDelegate {
    func didAuthenticated(result: SocialUserModel,
                          grantedPermissions: [SocialPermissionsType]?,
                          declinedPermissions: [SocialPermissionsType]?) {
        // send request to backend
        print(" ***** Done ***** \(result)")
    }
    
    func didFailWith(error: String?) {
        print(" ***** Error ***** \(error ?? "")")
    }
}
