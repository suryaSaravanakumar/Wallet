//
//  JsonReader.swift
//  wallet
//
//  Created by Surya on 21/05/21.
//

import Foundation


func readLocalFileAndParseData() -> WalletModel? {
    do {
        let name = "Wallet"
        if let bundlePath = Bundle.main.path(forResource: name,
                                             ofType: "json"),
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            let parsedData = try JSONDecoder().decode(WalletModel.self, from:  jsonData)
            return parsedData
        }
    } catch {
        print(error)
    }
    
    return nil
}
