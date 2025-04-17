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

//@Model public class UserPageTitles {
//    @Attribute public var userTitle: String?
//    @Attribute public var userTitleEmoji: String?
//    //@Attribute public var
//    
//    public init(userTitle: String? = nil, userTitleEmoji: String? = nil) {
//        self.userTitle = userTitle
//        self.userTitleEmoji = userTitleEmoji
//    }
//}

@Model public class UserPageTitle {
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
    //eventually, support for images and other structures will be added
}

@Model public class AuthKeys {                      //TO-DO: store OAuth key here
    @Attribute(.unique) public var oauthPermanentKey: String!
    
    public init(oauthPermanentKey: String!) {
        self.oauthPermanentKey = oauthPermanentKey
    }
}

    
     

