//
//  ImportUserPage.swift
//  MuscleMemory
//
//  Created by alex haidar on 12/22/24.
//


import Foundation



struct MainBlockBody: Codable, Identifiable {     //top level struct body for holding block content
    let id = UUID()
    let results: [Block]           // This will hold the list of Block objects
    
    private enum CodingKeys: CodingKey {
        case results
    }
    
    struct Block: Codable {
        let id = UUID()
        let paragraph: Paragraph?
        var ExtractedFields: [String] = []
        
        private enum CodingKeys: CodingKey {
            case paragraph
            
        }
    }
    struct Paragraph: Codable {
        let richText: [RichText]?
    }
    struct RichText: Codable {
        let text: NotionText?
    }
    struct NotionText: Codable {
        let content: String?
    }
}



class ImportUserPage: ObservableObject {
    
   
    @Published var mainBlockBody: MainBlockBody?
    let pageID = returnedBlocks.first?.id ?? "pageID is nil"
    
    public func pageEndpoint() async throws {
        let pagesEndpoint = "https://api.notion.com/v1/pages"
        let append = pagesEndpoint + "/pages\(pageID)"
        
        let addURL = URL(string: append)
        
        guard let url = addURL else { return }
        var request = URLRequest(url: url)
        
        if let authToken = accessToken {
            let appendToken = "Bearer " + authToken
            request.addValue(appendToken, forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("2022-06-28", forHTTPHeaderField: "Notion-Version")
            
        } else {
            print("headers could not be added or token could not be appended")
        }
        
        
        do {
            request.httpMethod = "POST"
            
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
                if let paragraph = returnDecodedResults[i].paragraph, let richText = paragraph.richText {
                    for text in richText {
                        if let content = text.text?.content {
                            extractedFields.append(content)
                            
                        }
                    }
                }
                returnDecodedResults[i].ExtractedFields = extractedFields
            }
            
        } catch {
            print("url session error:\(error)")
            if let decodeBlocksError = error as? DecodingError {
                print("error in decoding blocks\(decodeBlocksError)")
            }
        }
    }
}

