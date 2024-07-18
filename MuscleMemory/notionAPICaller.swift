//
//  notionAPICaller.swift
//  MuscleMemory
//
//  Created by alex haidar on 4/15/24.
//

import Foundation



struct BlockBody: Codable, Hashable, Identifiable {     //top level struct body for holding block content
    let id = UUID()
    let results: [Block]           // This will hold the list of Block objects
    
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    struct Block: Codable, Hashable, Identifiable {
        var id = UUID()
        let paragraph: Paragraph?
        var ExtractedFields: [String] = []
        
        private enum CodingKeys: String, CodingKey {
            case paragraph
        
        }
    }
    struct Paragraph: Codable, Hashable, Identifiable {
        let id = UUID()
        let textFields: [TextFields]
      
        
        private enum CodingKeys: String, CodingKey {
            case textFields 
   
        }
    }
    struct TextFields: Codable, Hashable, Identifiable {
        var id = UUID()
        let RichText: String?
        let content: String?
        
        private enum CodingKeys: String, CodingKey {
            case RichText = "rich_text"
            case content = "content"
       
        }
    }
}
    

    
    let url = URL(string: "https://api.notion.com/v1/blocks/8efc0ca3d9cc44fbb1f34383b794b817/children?page_size=100")   //change page size later
    let apiKey = "secret_Olc3LXnpDW6gI8o0Eu11lQr2krU4b870ryjFPJGCZs4"
    let session = URLSession.shared
    
    
    
    func makeRequest(completion: @escaping([BlockBody.Block]) -> Void) {
        guard let url = url else {return}
        
        var request = URLRequest(url: url)
        let header = "Bearer " + apiKey          //authorization header declaration
        request.addValue(header, forHTTPHeaderField: "authorization")            //append apikey
        request.addValue("2022-06-28",forHTTPHeaderField: "Notion-Version")          //specify version per notions requirments
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpError = error {
                print("could not establish HTTP connection:\(httpError)")
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                    } else {
                        print("invalid api key:\(httpResponse.statusCode)")
                    }
                }
            }
            
            if let unwrapData = data {     //safely unwrapping the data value using if let
                if let makeString = String(data: unwrapData, encoding: .utf8) {
                    print(makeString)
                } else {
                    print("no data is being returned:")
                }
                
                do {
                    let decoder = JSONDecoder()   //JSONDecoder method to decode api data
                    decoder.keyDecodingStrategy = .convertFromSnakeCase    //convert snake_case values notion forces me to use
                    
                    let codeUnwrappedData = try decoder.decode(BlockBody.self,from: unwrapData)     //"BlockBody." specifies the struct, from: passes the data parmeter that contains the api data to be decoded
                    Task { @MainActor in
                        completion(codeUnwrappedData.results)
                    }
                    
                   
                } catch let decodeError as DecodingError {
                    print("could not parse json data\(decodeError)")
                } catch {
                    print("data:",String(data: unwrapData, encoding: .utf8) ?? "data")
                    
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        print(String(data: unwrapData, encoding: .utf8)!)
                    } else {
                        print("unsuccessful http response:\(httpResponse)")
                    }
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 404 {
                        print(String(data: unwrapData, encoding: .utf8)!)
                    } else {
                        print("unable to access text block, block id does not exist:\(httpResponse)")
                    }
                }
            }
        }
        task.resume()
    }



  
    
    

