//
//  ViewCryptoControllerViewModel.swift
//  Crypto List
//
//  Created by Nick Khachatryan on 12.11.2024.
//

import UIKit

class ViewCryptoControllerViewModel {
    
    var onImageLoaded: ((UIImage?) -> Void)?

    //MARK: - PROPERTIES
    let coin: Coin
    
    
    //MARK: - INITIALIZERS
    init(_ coin: Coin) {
        self.coin = coin
        Task{
            await self.loadImage()
        }
    }
    
    
    private func loadImage() async {
        guard let logoURL = self.coin.logoURL else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: logoURL)
            
            if let logoImage = UIImage(data: data) {
                
                await MainActor.run {
                    self.onImageLoaded?(logoImage)
                }
            }
        } catch {
            print("Error loading image: \(error)")
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
