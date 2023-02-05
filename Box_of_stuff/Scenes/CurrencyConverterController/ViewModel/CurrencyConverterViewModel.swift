//
//  CurrencyConverterViewModel.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 22.11.22.
//

import Foundation

protocol CurrencyConverterProtocol {
    func addCurrencyRequest()
}

class CurrencyConverterViewModel: CurrencyConverterProtocol {
    
    private weak var viewController: CurrencyConverterControllerProtocol?
    
    init(viewController: CurrencyConverterControllerProtocol) {
        self.viewController = viewController
    }
    
    func addCurrencyRequest() {
        let url = "https://api.apilayer.com/fixer/latest?symbols=EUR%2CBYN%2CPLN%2CUAH%2CCNY%2CJPY%2CKZT%2CCZK%2CBGN&base=USD"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("6YjKV1yLqXtLwxQiszJhdm30yfTa2CcP", forHTTPHeaderField: "apikey")
        print("start")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            do {
                let currencyResponse = try JSONDecoder().decode(Currency.self, from: data)
                DispatchQueue.main.async { [self] in
                    viewController?.currencyRequest(with: currencyResponse)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
          print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
}
