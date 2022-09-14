//
//  CompanyData.swift
//  QRCodeScanner
//
//  Created by Sejal Khanna on 25/08/21.
//

import Foundation

// MARK: - Welcome
struct SuggestedTransactionModel: Codable {
    let userID: Int
    let transactions: [Transaction]

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case transactions
    }
}

// MARK: - Transaction
struct Transaction: Codable {
    let pictureid: Int
    let name: String
    let amount: Double
    let cashback: Double
}

