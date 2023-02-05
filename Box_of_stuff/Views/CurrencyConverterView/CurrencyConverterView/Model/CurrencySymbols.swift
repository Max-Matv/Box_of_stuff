//
//  CurrencyCymbols.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 26.01.23.
//

import Foundation

final class Symbols {
    
    static func getIcon(_ icon: String) -> String {
        switch icon {
        case "USD", "CAD", "MXN", "BBD", "BMD", "BSD", "DOP", "JMD", "XCD", "ARS", "CLP", "COP", "UYU", "HKD", "SGD", "TWD", "AUD", "FJD", "NZD", "NAD":
            return "$"
        case "AWG":
            return "ƒ"
        case "GTQ":
            return "Q"
        case "PAB":
            return "B/."
        case "EUR":
            return "€"
        case "GBP", "EGP", "SYP":
            return "£"
        case "GEL":
            return "₾"
        case "BGN":
            return "лв"
        case "CHF":
            return "CHF"
        case "DKK":
            return "kr"
        case "CZK":
            return "Kč"
        case "HRK":
            return "kn"
        case "HUF":
            return "ft"
        case "NOK":
            return "kr"
        case "RUB":
            return "₽"
        case "PLN":
            return "zł"
        case "RON":
            return "lei"
        case "SEK":
            return "kr"
        case "UAH":
            return "₴"
        case "TRY":
            return "₺"
        case "BOB", "VES":
            return "Bs."
        case "BRL":
            return "R$"
        case "PEN":
            return "S/."
        case "PYG":
            return "₲"
        case "JPY", "CNY":
            return "¥"
        case "BDT":
            return "৳"
        case "INR":
            return "₹"
        case "KHR":
            return "៛"
        case "LAK":
            return "₭"
        case "LKR":
            return "රු"
        case "MVR":
            return ".ރ"
        case "MYR":
            return "RM"
        case "NPR":
            return "रू"
        case "PHP":
            return "₱"
        case "PKR", "MUR", "SCR":
            return "₨"
        case "THB":
            return "฿"
        case "VND":
            return "₫"
        case "XPF":
            return "₣"
        case "GHS":
            return "₵"
        case "GMD":
            return "D"
        case "KES", "UGX":
            return "Sh"
        case "MAD":
            return "DH"
        case "MGA":
            return "Ar"
        case "NGN":
            return "₦"
        case "TND":
            return "DT"
        case "XAF", "XOF":
            return "Fr"
        case "AED":
            return "د.إ"
        case "ILS":
            return "₪"
        case "JOD":
            return "د.ا"
        case "KWD":
            return "د.ك"
        case "LBP":
            return "ل.ل"
        case "OMR":
            return "ر.ع."
        case "QAR":
            return "ر.ق"
        default:
            return "¤"
        }
    }
}
