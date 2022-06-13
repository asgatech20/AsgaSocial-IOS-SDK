//
//  SocialPermissionsType.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 6/1/22.
//

import Foundation
import AuthenticationServices

/// The Type of permissions that can be requested from the user
public enum SocialPermissionsType: String {
    case publicProfile = "public_profile"
    case email = "email"
    case fullName = "fullName"
    case birthday = "user_birthday"
    case gender = "user_gender"
}

//MARK: Handle Permissions
extension SocialPermissionsType {
    /**
     enable to parse each permission to it's appropriate return according to social provider type
     - Parameters:
        - items:  array of social provider permissions type
        - providerType: type of social provider
     - Returns:  in case provider is  facebook -> [String] , apple -> [ASAuthorization.Scope]
     */
    static func handlePermissions(_ items: [SocialPermissionsType], providerType: ProviderType) -> [Any] {
        switch providerType {
        case .facebook:
            return handleFacebookPermissions(items)
        case .apple:
            return handleApplePermissions(items)
        default:
            return []
        }
    }
    
    /**
     enable to parse each permission type to it's suitable string for facebook provider
     - Parameters:
        - items: array of social provider permissions type
     - Returns:
        array of string values of permission type parser
     */
    private static func handleFacebookPermissions(_ items: [SocialPermissionsType]) -> [String] {
        items.compactMap({$0.facebookPermissionsParser})
    }
    
    /**
     enable to parse each permission type to it's suitable string value for apple provider
     - Parameters:
        - items: array of social provider permissions type
     - Returns:
         array of ASAuthorization.Scope which mean The kinds of contact information that can be requested from the user.
     */
    private static func handleApplePermissions(_ items: [SocialPermissionsType]) -> [ASAuthorization.Scope] {
        items.compactMap({$0.applePermissionsParser})
    }
    
}

//MARK: Apple Permissions Parser
extension SocialPermissionsType {
    /**
       computed property which return the equivalent of SocialPermissionsType with ASAuthorization.Scope type
    */
    var applePermissionsParser: ASAuthorization.Scope {
        switch self {
        case .email:
            return .email
        case .fullName:
            return .fullName
        default:
            return .email
        }
    }
    
}

//MARK: Facebook Permissions Parser
extension SocialPermissionsType {
    /**
       computed property which return the equivalent of SocialPermissionsType with parser string value
    */
    var facebookPermissionsParser: String {
        switch self {
        case .publicProfile:
            return "public_profile"
        case .email:
            return "email"
        case .fullName:
            return "fullName"
        case .birthday:
            return "user_birthday"
        case .gender:
            return "user_gender"
        }
    }
}

//MARK: Handle Social Provider Parameters
extension SocialPermissionsType {
    /**
     computed property which return the equivalent of Social Permissions Type with it's parameter string value
     */
    var facebookParameterParser: String {
        switch self {
        case .publicProfile:
            return "id, name, first_name, last_name, picture.type(large)"
        case .email:
            return "email"
        case .fullName:
            return "name"
        case .birthday:
            return "birthday"
        case .gender:
            return "gender"
        }
    }
    
    //MARK: Facebook Parameters
    /**
     enable to parse each permission to it's appropriate return according to social provider type
     - Parameters:
        - items:  array of social provider permissions type
        - providerType: type of social provider
     - Returns:  string contains all parameters requested joined together
     */
    public static func handleParameters(_ items: [SocialPermissionsType], providerType: ProviderType) -> String {
        switch providerType {
        case .facebook:
            return handleFacebookParameters(items)
        default:
            return ""
        }
    }
    
    /**
     enable to parse each permission type to it's suitable string value for facebook provider
     - Parameters:
        - items: array of social provider permissions type
     - Returns:
         string contains all parameters requested joined together
     */
    private static func handleFacebookParameters(_ items: [SocialPermissionsType]) -> String {
        let parsedItems = items.compactMap({$0.facebookParameterParser})
        let params = parsedItems.joined(separator: ", ")
        return params
    }
}


