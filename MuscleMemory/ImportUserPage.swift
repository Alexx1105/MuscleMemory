//
//  ImportUserPage.swift
//  MuscleMemory
//
//  Created by alex haidar on 12/22/24.
//


import Foundation
import SwiftData


struct MainBlockBody: Codable, Identifiable {
    let id = UUID()
    let results: [Block]
    
    private enum CodingKeys: CodingKey {
        case results
    }
    
    struct Block: Codable {
        let id: String
        let paragraph: Paragraph?
        var ExtractedFields: [String] = []
        
        private enum CodingKeys: CodingKey {
            case id
            case paragraph
        }
    }
    struct Paragraph: Codable {
        let rich_text: [RichText]?
    }
    struct RichText: Codable {
        let text: NotionText?
    }
    struct NotionText: Codable {
        let content: String?
    }
}


@MainActor
class ImportUserPage: ObservableObject {
    
    public static let shared = ImportUserPage()
    @Published var mainBlockBody: [MainBlockBody.Block] = []
    var appendedID: String?
    
    var modelContextPage: ModelContext?
    public func modelContextPagesStored(pagesContext: ModelContext?) {
        self.modelContextPage = pagesContext
    }
    
    var userContentPage: String?
    var userPageId: String?
    
    public func pageEndpoint() async throws {
        let pageID = returnedBlocks.first?.id ?? "pageID is nil"
        let pagesEndpoint = "https://api.notion.com/v1/blocks/"
        let append = pagesEndpoint + "\(pageID)/children"
        
        
        appendedID = append                                //assign before being compared so it is not nil by default
        
        if appendedID == append {                        
            print("page ID was appended")
        } else {
            print("page id could not be appended")
        }
        
        if let unwrappedPageID = appendedID {
            print("pageID was successfully unwrapped before being passed to URL method:\(unwrappedPageID)")
        }
        
        let addURL = URL(string: appendedID ?? "appendedID could not be converted back into a URL (nill)")
      
       
        guard let url = addURL else { return }
            var request = URLRequest(url: url)
            
            if let authToken = accessToken {
                let appendToken = "Bearer " + authToken
                request.addValue("2022-06-28", forHTTPHeaderField: "Notion-Version")
                request.addValue(appendToken, forHTTPHeaderField: "Authorization")
                print("page ID was successfully appended to the url")
                print(appendToken)
            } else {
                print("headers could not be added or token could not be appended")
            }
            
            
            do {
                request.httpMethod = "GET"
                
                let (userData, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                if let decodeString = String(data: userData, encoding: .utf8) {
                    print(decodeString)
                } else {
                    print("error decoding string")
                }
                
                let decodePageData = JSONDecoder()
                let decodePage = try decodePageData.decode(MainBlockBody.self, from: userData)
                var returnDecodedResults = decodePage.results
                
                
                for i in 0..<returnDecodedResults.count {
                    var extractedFields: [String] = []
                    if let paragraph = returnDecodedResults[i].paragraph, let richText = paragraph.rich_text {
                        for text in richText {
                            if let content = text.text?.content {
                                extractedFields.append(content)
                                
                            }
                        }
                    }
                returnDecodedResults[i].ExtractedFields = extractedFields
              }
            
                
                DispatchQueue.main.async {
                    self.mainBlockBody = returnDecodedResults
                }
        
               
                
                for i in returnDecodedResults {
                        for concatStrings in i.ExtractedFields {
                            
                            let storedPages = UserPageContent(userContentPage: concatStrings, userPageId: i.id)
                            modelContextPage?.insert(storedPages)
                            try modelContextPage?.save()
                        }
                    
                }
        
                
            } catch {
                print("url session error:\(error)")
                if let decodeBlocksError = error as? DecodingError {
                    print("error in decoding blocks\(decodeBlocksError)")
                }
            }
        }
    }

