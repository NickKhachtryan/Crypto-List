//
//  ViewCryptoControllerViewModel.swift
//  Crypto List
//
//  Created by Nick Khachatryan on 12.11.2024.
//

import UIKit

class ViewCryptoControllerViewModel {
    
    @MainActor var onImageLoaded: ((UIImage?) -> Void)?

    //MARK: - PROPERTIES
    let coin: Coin
    
    
    //MARK: - INITIALIZERS
    init(_ coin: Coin) {
        self.coin = coin
        Task{
            await self.loadImage()
        }
    }
    
    private func fetchImage() async throws -> UIImage {
        guard let url = self.coin.logoURL else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let image = UIImage(data: data) else { throw URLError(.cannotDecodeContentData) }
            return image
            
        } catch {
            throw error
        }
    }
    
    @MainActor private func loadImage() async {
        do {
            let logoImage = try await fetchImage()
            self.onImageLoaded?(logoImage)
        } catch {
            print("error")
        }
    }

    
    
    //MARK: - COMPUTED PROPERTIES
    var rankLabel: String {
        return "Rank: \(coin.cmc_rank)"
    }
    
    var priceLabel: String {
        return "Price: \(coin.quote.USD.price) $"
    }
    
    var marketCapLabel: String {
        return "Market Cap: \(coin.quote.USD.market_cap)"
    }
    
    var maxSupplyLabel: String {
        
        if let maxSupply = coin.max_supply {
            return "Maximum Supply: \(maxSupply)"
        } else {
            return "bulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba аа"
        }
        
    }
}
