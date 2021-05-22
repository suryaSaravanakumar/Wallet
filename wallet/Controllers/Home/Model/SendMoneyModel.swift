//
//  SendMoneyModel.swift
//  wallet
//
//  Created by Surya on 16/05/21.
//

import Foundation


// MARK: - Welcome
struct WalletModel: Codable,Hashable {
    let userName, userID: String
    let currentBalance: Int
    let friendsList: [FriendsList]
    let mySpend: [MySpend]

    enum CodingKeys: String, CodingKey {
        case userName
        case userID = "userId"
        case currentBalance, friendsList, mySpend
    }
}

// MARK: - FriendsList
struct FriendsList: Codable,Hashable {
    let name, phone: String
}

// MARK: - MySpend
struct MySpend: Codable,Hashable {
    let title, amount, time: String
}
