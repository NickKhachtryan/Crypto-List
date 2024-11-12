//
//  CoinCell.swift
//  Crypto List
//
//  Created by Nick Khachatryan on 12.11.2024.
//

import UIKit

class CoinCell: UITableViewCell {
    
    
    //MARK: - PROPERTIES
    
    static let identifier = "CoinCell"
    
    private(set) var coin: Coin!
    
    
    //MARK: - UIComponents
    
    private let coinLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "square.and.arrow.up.fill")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Error"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - LIFE CYCLE
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchImage() async throws -> UIImage {
        
        guard let url = self.coin.logoURL else { throw URLError(.badURL) }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let image = UIImage(data: data) else { throw URLError(.cannotDecodeContentData) }
            return image
            
        } catch {
            throw error
        }
    }
    
    @MainActor public func configure(with coin: Coin) async {
        
        self.coin = coin
        self.coinName.text = coin.name
        
        do {
            self.coinLogo.image = try await fetchImage()
        } catch {
            print("error")
            self.coinLogo.image = nil
        }
    }
    
    
    
    
    
    
    //MARK: - CONSTRAINTS
    
    private func setupUI() {
        
        self.addSubview(coinLogo)
        NSLayoutConstraint.activate([
            coinLogo.centerYAnchor.constraint(equalTo: centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            coinLogo.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
        ])
        
        self.addSubview(coinName)
        NSLayoutConstraint.activate([
            coinName.centerYAnchor.constraint(equalTo: centerYAnchor),
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 16)
        ])
    }
}
