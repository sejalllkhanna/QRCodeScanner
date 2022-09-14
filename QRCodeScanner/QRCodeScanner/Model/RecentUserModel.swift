//
//  UserModel.swift
//  QRCodeScanner
//
//  Created by Sejal Khanna on 30/08/21.
//
import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let customerID: Int
    let suggestedContacts: [SuggestedContact]

    enum CodingKeys: String, CodingKey {
        case customerID = "customerId"
        case suggestedContacts
    }
}

// MARK: - SuggestedContact
struct SuggestedContact: Codable {
    let upiAddress, name, pictureURL: String
    let mobileNumber: Int

    enum CodingKeys: String, CodingKey {
        case upiAddress, name
        case pictureURL = "pictureUrl"
        case mobileNumber
    }
}
