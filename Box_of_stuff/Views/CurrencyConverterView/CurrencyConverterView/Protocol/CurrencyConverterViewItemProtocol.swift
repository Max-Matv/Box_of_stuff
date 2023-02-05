//
//  CurrencyConverterViewProtocol.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 7.01.23.
//

import Foundation

protocol CurrencyConverterViewItemDelegate: AnyObject {
    func CurrencyDataDidChange(_ sender: CurrencyConverterItem)
    func CurrencyNameDidChange(_ sender: CurrencyConverterItem)
}
