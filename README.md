# AsgaSocialSDK
AsgaSocialSDK is an iOS Library which used to facilitate the login with different social  
ways in your app, until now you can login with apple, google, facebook and twitter.

## Installation

AsgaSocialSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AsgaSocialSDK"
```

# Usage

```swift
// initialize var from SocialHelper class for login with Google, Facebook and Twitter
var socialAuthHelper = SocialHelper.init(viewController: self,
                                         Permissions: [.publicProfile,
                                                      .email])
// to implement login with Google
socialAuthHelper.launchGoogleLogin()

// to implement login with Facebook
socialAuthHelper.launchFacebookLogin()

// to implement login with Twitter
socialAuthHelper.launchTwitterLogin()

// For Apple Login Implementation                                
var appleAuthHelper = AppleAuthenticationHelper(vc: self,
                                                permissions: permissions)
appleAuthHelper.launchAppleLogin()
```      
# Configurations
for login with Google or Twitter Set this variables in AppDelegate.swift file:

```swift
// in case login with Google, set the googleClientID
SocialGoogleAuthCredential.shared.googleClientID = "googleClientID"

// in case login with Twitter, set this configurations
SocialTwitterAuthCredential.shared.twitterConsumerSecret = "twitterConsumerSecret"
SocialTwitterAuthCredential.shared.twitterAuthCallBackUrl = "twitterAuthCallBackUrl"
SocialTwitterAuthCredential.shared.twitterConsumerKey = "twitterConsumerKey"

```      

## Author
* [Ibrahim Ali](https://github.com/IbrahimAli2017)
* [Zeynab Ahmed](https://github.com/ZeynabAhmed)
