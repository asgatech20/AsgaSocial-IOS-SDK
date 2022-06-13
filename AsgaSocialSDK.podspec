
Pod::Spec.new do |spec|

  spec.name         = "AsgaSocialSDK"
  spec.version      = "0.0.1"
  spec.summary      = "AsgaSocialSDK is a social media login"

  spec.description  = "AsgaSocialSDK for login with different social media and google"

  spec.homepage     = "https://github.com/asgatech20/AsgaSocial-IOS-SDK.git"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  spec.license      = "MIT (example)"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author       = { "Zeynab" => "zinab.ahmed@asgatech.com" }

  spec.ios.deployment_target = "13.0"

  spec.source       = { :git => "https://github.com/asgatech20/AsgaSocial-IOS-SDK.git", :tag => "1.0.0" }

  spec.source_files  = "AsgaSocialSDK"
  spec.exclude_files = "Classes/Exclude"
  
  spec.dependency "GoogleSignInt"
  spec.dependency "FBSDKLoginKit"
  spec.dependency "Swifter"
end
