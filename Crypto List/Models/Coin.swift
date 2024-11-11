//
//  Coin.swift
//  Crypto List
//
//  Created by Nick Khachatryan on 12.11.2024.
//

import Foundation

struct Coin {
    
    let id: Int
    let name: String
    let max_supply: Int?
    let cmc_rank: Int
    let quote: Quote
    
    struct Quote {
        let USD: USD
        
        struct USD {
            let price: Double
            let market_cap: Double
        }
    }
}


extension Coin {
    public static func getMockArray() -> [Coin]{
        return [
            Coin(id: 1, name: "Bitcoin", max_supply: 200, cmc_rank: 1, quote: Quote(USD: Quote.USD(price: 50000, market_cap: 1_000_000))),
            Coin(id: 2, name: "Etherium", max_supply: nil, cmc_rank: 2, quote: Quote(USD: Quote.USD(price: 2000, market_cap: 500_000))),
            Coin(id: 3, name: "Monero", max_supply: nil, cmc_rank: 3, quote: Quote(USD: Quote.USD(price: 200, market_cap: 250_000)))
        ]
    }
}
