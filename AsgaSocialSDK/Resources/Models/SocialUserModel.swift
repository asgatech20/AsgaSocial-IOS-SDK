//
//  SocialInputModel.swift
//  AsgaSocialSDK
//
//  Created by Zinab Ahmed on 15/05/2021.
//

import Foundation

/// User Contact Information that returned from login with Social
public struct SocialUserModel {
    public var providerId = ""
    public var fullName = ""
    public var fName = ""
    public var lName = ""
    public var image = ""
    public var email = ""
    public var gender = ""
    public var birthdate = ""
    public var phone = ""
    public var providerType: ProviderType = .google
}
