//
//  CurrencyRequest.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 23.11.22.
//

import Foundation

struct Currency: Codable {
    let base: String
    let date: String
    let rates: [String: Double]
    let success: Bool
    let timestamp: Int
}
