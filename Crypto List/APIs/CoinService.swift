//
//  CoinService.swift
//  Crypto List
//
//  Created by Nick Khachatryan on 17.11.2024.
//

import Foundation

enum CoinServiceError: Error {
    case serverError(CoinError)
    case unknownError(String = "An unknown error occured")
    case decodingError(String = "Error parsing error response")
}

class CoinService {
    
    static func fetchCoins(with endpoint: Endpoint) async throws -> [Coin] {
        
        guard let request = endpoint.request else {
            throw CoinServiceError.unknownError("Invalid request")
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                do {
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data)
                    throw CoinServiceError.serverError(coinError)
                } catch {
                    throw CoinServiceError.unknownError("Failed to decode server error")
                }
            }
            
            let decoder = JSONDecoder()
            do {
                let coinData = try decoder.decode(CoinArray.self, from: data)
                return coinData.data
            } catch {
                throw CoinServiceError.decodingError("Failed to decode coin data")
            }
            
        } catch {
            throw CoinServiceError.unknownError(error.localizedDescription)
        }
    }
}
