//
//  HTTP.swift
//  Crypto List
//
//  Created by Nick Khachatryan on 16.11.2024.
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case get = "GET"
    }
    
    enum Header {
        enum Key: String {
            case contentType = "Content-Type"
            case apiKey = "X-CMC_PRO_API_KEY"
        }
        
        enum  Value: String {
            case applicationJSON = "application/json"
        }
    }
    
}
