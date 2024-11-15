//
//  Coin.swift
//  Crypto List
//
//  Created by Nick Khachatryan on 12.11.2024.
//

import Foundation

struct CoinArray: Decodable {
    let data: [Coin]
}

struct Coin: Decodable {
    let id: Int
    let name: String
    let maxSupply: Int?
    let rank: Int
    let pricingData: Quote
    
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/\(id).png")
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case maxSupply = "max_supply"
        case rank = "cmc_rank"
        case pricingData = "quote"
    }
}

struct Quote: Decodable {
    let USD: USD
    
}

struct USD: Decodable {
    let price: Double
    let market_cap: Double
}


