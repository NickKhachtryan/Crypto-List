//
//  CoinError.swift
//  Crypto List
//
//  Created by Nick Khachatryan on 15.11.2024.
//

import Foundation

struct CoinStatus: Decodable {
    let status: CoinError
}

struct CoinError: Decodable {
    let errorCode: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}
