//
//  PersistantDB.swift
//  MuscleMemory
//
//  Created by alex haidar on 3/29/25.
//

import Foundation
import SwiftData
import SwiftUI



@Model public class UserEmail {                                     //email from Oauth flow
    @Attribute(.unique) public var personEmail: String?

    public init(personEmail: String?) {
        self.personEmail = personEmail
    }
}

@Model public class UserPageContent {                               //imported notion body 
    @Attribute public var userContentPage: String?
    @Attribute public var userPageId: String?
    
    public init(userContentPage: String? = nil, userPageId: String? = nil) {
        self.userContentPage = userContentPage
        self.userPageId = userPageId
    }
}

@Model public class UserPageTitle {                             //tab title + optional emojis
    @Attribute public var id: String?
    @Attribute public var icon: String?
    @Attribute public var plain_text: String?
    @Attribute public var emoji: String?
    
    public init(id: String?, icon: String?, plain_text: String?, emoji: String?) {
        self.id = id
        self.icon = icon
        self.plain_text = plain_text
        self.emoji = emoji
    }
}


//@Model public class AuthKeys {                                //TO-DO: store OAuth key here later
//    @Attribute(.unique) public var oauthPermanentKey: String!
//    
//    public init(oauthPermanentKey: String!) {
//        self.oauthPermanentKey = oauthPermanentKey
//    }
//}
//
//    
     

