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
            print("Coin Image Fetched", Thread.current)
            return image
            
        } catch {
            throw error
        }
        
    }
    
    @MainActor private func loadImage() async {
        
        do {
            let logoImage = try await fetchImage()
            self.onImageLoaded?(logoImage)
            print("Coin Image Loaded to the UI", Thread.current)
        } catch {
            print("error")
        }
    }

    
    //MARK: - COMPUTED PROPERTIES
    
    var rankLabel: String {
        return "Rank: \(coin.rank)"
    }
    
    var priceLabel: String {
        return "Price: \(coin.pricingData.USD.price) $"
    }
    
    var marketCapLabel: String {
        return "Market Cap: \(coin.pricingData.USD.market_cap)"
    }
    
    var maxSupplyLabel: String {
        
        if let maxSupply = coin.maxSupply {
            return "Maximum Supply: \(maxSupply)"
        } else {
            return "bulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba\nbulba аа"
        }
        
    }
}
