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
        public let properties: properties?
        public let icon: Icon?
    }
    
    public struct Icon: Codable {
        public let type: String?
        public let emoji: String?
    }
    
    public struct properties: Codable {
        public let title: TitleDict?
    }
    
    public struct TitleDict: Codable {
        public let title: [TitleItem]
    }
    public struct TitleItem: Codable {
        public let plain_text: String?
    }
}


    public var returnedBlocks: [NotionSearchRequest.result] = []
   
   
@MainActor
public class searchPages: ObservableObject {
    
    static let shared = searchPages()
   
    @Published var emojis: NotionSearchRequest.Icon?
    @Published var displaying: NotionSearchRequest.TitleItem?
    @Published var userBlocks: NotionSearchRequest.result?
   
    let searchEndpoint = URL(string: "https://api.notion.com/v1/search")
    
    private init() { }
    
    public func userEndpoint() async throws {
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
           
            let title = decodedPageStrings.results.first
            let getText = title?.properties?.title
            let text = getText?.title.first?.plain_text
            let emojis = title?.icon?.emoji
            let customType = title?.icon?.type
          
           
            DispatchQueue.main.async {
                
                if let titles = text {
                   
                    self.displaying = NotionSearchRequest.TitleItem(plain_text: titles)
                        print("being passed to main thread: \(titles)")
                    } else {
                        print("plain text is not being run on main")
                    }
                
                if let storeEmoji = emojis {
                    self.emojis = NotionSearchRequest.Icon(type: customType, emoji: storeEmoji)
                    print("emoji has been stored🫡\(storeEmoji)")
                } else {
                    print("emoji could not be successfully stored")
                }
            }
          
            if let pageID = returnedBlocks.first?.id, let objectBlocks = accessObject, let displayTitle = text, let showEmoji = emojis {
                print("page ID: \(pageID)")
                print("content: \(objectBlocks)")
                print("title of page: \(displayTitle)")
                print("emoji from title:\(showEmoji)")
                } else {
                    print("nil body params")
                    print("title page could not be stored")
                }
         
            
        } catch {
            print("bad response")
            if let decodeBlocksError = error as? DecodingError {
                print("error in decoding blocks\(decodeBlocksError)")
            }
        }
    }
}




