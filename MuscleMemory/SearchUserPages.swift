//
//  ImportUserPages.swift
//  MuscleMemory
//
//  Created by alex haidar on 12/8/24.
//

import Foundation


public struct NotionSearchRequest: Codable {    //add other properties (if needed) later
    public let results: [result]
    public let object: String?
  
    
    public struct result: Codable {
        public let id: String?
        public let object: String?
    }
}


    public var returnedBlocks: [NotionSearchRequest.result] = []

class searchPages {
    
    @Published var userBlocks: NotionSearchRequest.result?
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
            returnedBlocks = decodedPageStrings.results
            let accessObject = returnedBlocks.first?.object
         
            if let pageID = returnedBlocks.first?.id, let objectBlocks = accessObject {
                print("page ID: \(pageID)")
                print("content: \(objectBlocks)")
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




