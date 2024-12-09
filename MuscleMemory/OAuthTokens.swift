//
//  OAuthTokens.swift
//  MuscleMemory
//
//  Created by alex haidar on 12/7/24.
//

import Foundation
import SwiftUI


class OAuthTokens: ObservableObject {
    
    
    func exchangeToken(authorizationCode: String) {
        let tokenURL = URL(string: "https://api.notion.com/v1/oauth/token")!
        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        let requestBody = "application/x-www-form-urlencoded\(authorizationCode)&https://notionauthbridge-rhuwa73w2a-uc.a.run.app/callback?code=AUTHORIZATION_CODE"    //format post request body for token exchange
        request.httpBody = requestBody.data(using: .utf8)
        URLSession.shared.dataTask(with: request ) { data, response, error in
            if let tokenData = data {
                print("auth token was recieved\(tokenData)")
            } else {
                print("auth token exchange failed")
            }
        } .resume()
    }
}
