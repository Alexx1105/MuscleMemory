//
//  ImportUserPages.swift
//  MuscleMemory
//
//  Created by alex haidar on 12/8/24.
//

import Foundation


struct NotionSearchRequest: Codable {
    let query: String?
    let sort: Sort?
    let filter: Filter?

    
    struct Sort: Codable {
        let direction: String     // "ascending" or "descending"
        let timestamp: String     // e.g., "last_edited_time"
    }
    
    struct Filter: Codable {
        let value: String?        // "page" or "database"
        let property: String?    // Always "object"
    }
}



class searchPages {
    
    @Published var userBlocks: NotionSearchRequest.Sort?
    
    
    let searchEndpoint = URL(string: "https://api.notion.com/v1/search")
    
    func userEndpoint() async throws {
        guard let url = searchEndpoint else { return }
        var request = URLRequest(url: url)
        
        if let passToken = accessToken {
            request.addValue("Bearer \(passToken)", forHTTPHeaderField: "Authorization")
            request.addValue("2022-06-28", forHTTPHeaderField: "Notion-Version")
            
        } else {
            print("header values could not be added")
        }
    
        do {
            request.httpMethod = "POST"
            
            let (userData, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            if let dataString = String(data: userData, encoding: .utf8) {
                print(dataString)
            } else {
                print("empty data string")
            }
            let decodePageData = JSONDecoder()
            let decodedPageStrings = try decodePageData.decode(NotionSearchRequest.self, from: userData)
            let returnedBlocks = decodedPageStrings.sort
            
            if let ts = returnedBlocks?.timestamp, let dir = returnedBlocks?.direction {    // unwrap timestamp and direction fields
                print("blocks:\(ts)")
                print("blocks:\(dir)")
            } else {
                print("nil body params")
            }
            
            
            
        } catch {
            print("bad response")
            if let decodeBlocksError = error as? DecodingError {
                print("error in decoding blocks\(decodeBlocksError)")
            }
        }
    }
}




