# AsgaSocialSDK
     AsgaSocialSDK is an iOS Library which used to facilitate the login with different social ways in your app, until now you can login with apple, google, facebook and twitter.

## Installation

AsgaSocialSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AsgaSocialSDK"
```

# Usage

```swift
var socialAuthHelper = SocialHelper.init(viewController: self,
                                        Permissions: [.publicProfile,
                                                      .email])

// to implement login with Apple
socialAuthHelper.launchAppleLogin()

// to implement login with Google
socialAuthHelper.launchGoogleLogin()

// to implement login with Facebook
socialAuthHelper.launchFacebookLogin()

// to implement login with Twitter
socialAuthHelper.launchTwitterLogin()
                               
```      

## Author
* [Ibrahim Ali](https://github.com/IbrahimAli2017)
* [Zeynab Ahmed](https://github.com/ZeynabAhmed)
