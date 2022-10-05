
Pod::Spec.new do |spec|

  spec.name         = "AsgaSocialSDK"
  spec.version      = "1.0.7"
  spec.summary      = "AsgaSocialSDK is a social media login"

  spec.description  = <<-DESC
        AsgaSocialSDK is an iOS Library which used to facilitate the login with different social ways in your app, until now you can login with apple, google, facebook and twitter.
        DESC

  spec.homepage     = "https://github.com/asgatech20/AsgaSocial-IOS-SDK.git"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author       = { "Zeynab" => "zinab.ahmed@asgatech.com" }

  spec.ios.deployment_target = "11.0"

  spec.source       = { :git => "https://github.com/asgatech20/AsgaSocial-IOS-SDK.git", :tag => "#{spec.version}" }

  spec.source_files  = "AsgaSocialSDK/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"
  
  spec.dependency "GoogleSignIn"
  spec.dependency "FBSDKLoginKit"
  spec.dependency "Swifter"
end
