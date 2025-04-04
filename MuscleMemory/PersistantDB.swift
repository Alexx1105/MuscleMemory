//
//  PersistantDB.swift
//  MuscleMemory
//
//  Created by alex haidar on 3/29/25.
//

import Foundation
import SwiftData
import SwiftUI


    
@Model public class UserEmail {
    @Attribute(.unique) public var personEmail: String?
    
    public init(personEmail: String?) {
        self.personEmail = personEmail
    }
}

@Model public class UserPageTitles {
    @Attribute public var userTitle: String?
    @Attribute public var userTitleEmoji: String?
    
    public init(userTitle: String? = nil, userTitleEmoji: String? = nil) {
        self.userTitle = userTitle
        self.userTitleEmoji = userTitleEmoji
    }
}

@Model public class UserPageContent {
    @Attribute public var userContent: String?
    @Attribute(.unique) public var userPageID: String!
    @Attribute public var userContentEmoji: String?
    
    public init(userContent: String? = nil, userPageID: String!, userContentEmoji: String? = nil, userTitleEmoji: String? = nil) {
        self.userContent = userContent
        self.userPageID = userPageID
        self.userContentEmoji = userContentEmoji
    }
    //eventually, support for images and other structures will be added
}

@Model public class AuthKeys {
    @Attribute(.unique) public var oauthPermanentKey: String!
    
    public init(oauthPermanentKey: String!) {
        self.oauthPermanentKey = oauthPermanentKey
    }
   
}

    
     

