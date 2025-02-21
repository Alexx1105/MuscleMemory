//
//  OAuthTokens.swift
//  MuscleMemory
//
//  Created by alex haidar on 12/7/24.
//

import Foundation
import SwiftUI




public var accessToken: String?
class OAuthTokens: ObservableObject {
    
    static let shared = OAuthTokens()
    @Published var email: String?
    
    public func exchangeToken(authorizationCode: String) async throws {
        let tokenURL = URL(string: "https://api.notion.com/v1/oauth/token")!
        var request = URLRequest(url: tokenURL)
        
        let client = "138d872b-594c-8050-b985-0037723b58e0"
        let secret = "secret_HgvrwXDCKSYBusm3UorlPpLu9fKWk5aKt5n6vxXo4SX"
        
        let idAndSecret = "\(client):\(secret)"
        let base64EncodedIDAndSecret = Data(idAndSecret.utf8).base64EncodedString()
        
        request.addValue("Basic \(base64EncodedIDAndSecret)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue( "2022-06-28", forHTTPHeaderField: "Notion-Version")
        
        let requestBody: [String: Any] = ["grant_type": "authorization_code", "code": authorizationCode, "redirect_uri": "https://notionauthbridge-rhuwa73w2a-uc.a.run.app/callback?code=AUTHORIZATION_CODE"]
        
        request.httpMethod = "POST"
        let jsonData = try? JSONSerialization.data(withJSONObject: requestBody)
        request.httpBody = jsonData
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            do {
                if let dataDict = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print(dataDict)
                    if let storedToken = dataDict["access_token"] as? String {
                        accessToken = storedToken
                        print("stored token: \(storedToken)")
                        
                    }  else {
                        print("access token could not be stored")
                    }
                    if let ownerData = dataDict["owner"] as? [String: Any] {
                        if let userData = ownerData["user"] as? [String: Any] {
                            if let personDict = userData["person"] as? [String: Any] {
                                if let personEmail = personDict["email"] as? String {
                                    print("GOT EMAIL WOO! \(personEmail)")
                                    
                                    await MainActor.run {
                                        email = personEmail
                                    }
                                }
                            }
                        }
                    }
                }
            } catch {
                print("token could not be parsed:\(error.localizedDescription)")
            }
        } catch let error {
            print("auth token exchange failed: \(error)")
        }
    }
}

