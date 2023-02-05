//
//  CurrencyConverterViewController.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 31.10.22.
//

import UIKit
import SwiftUI

protocol CurrencyConverterControllerProtocol: AnyObject{
    func currencyRequest(with response: Currency)
}

class CurrencyConverterViewController: UIViewController {
    
    lazy var currencyView: CurrencyConverterView = {
        let view = CurrencyConverterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: CurrencyConverterProtocol?
    private var currency: Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = GradientView()
        viewModel?.addCurrencyRequest()
        setupViewController()
    }
    
    private func setupViewController() {
        view.addSubview(currencyView)
        currencyView.delegate = self
        NSLayoutConstraint.activate([
            currencyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currencyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc
    private func hideKeyboard(_ sender: UIView) {
        self.view.endEditing(true)
    }
}

extension CurrencyConverterViewController: CurrencyConverterViewDelegate {
    func CurrencyViewButtonPressed(_ sender: CurrencyConverterItem) {
        let controller = PopoverViewController()
        controller.modalPresentationStyle = .popover
        let popoverVC = controller.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = sender
        popoverVC?.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY, width: 0, height: 0)
        controller.preferredContentSize = CGSize(width: sender.frame.width, height: view.frame.height / 3)
        controller.currencyList = currencyView.getCurrencyList()
        controller.completion = { currencyName in
            sender.setCurrency(currencyName)
        }
        present(controller, animated: true)
    }
    
}

extension CurrencyConverterViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

extension CurrencyConverterViewController: CurrencyConverterControllerProtocol {
    func currencyRequest(with response: Currency) {
        currencyView.setup(currency: response)
    }
}

struct CurrencyProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let controller = CurrencyConverterViewController()
        func makeUIViewController(context: Context) -> CurrencyConverterViewController {
            controller.currencyView.testFunc()
            return controller
        }
        
        func updateUIViewController(_ uiViewController: CurrencyConverterViewController, context: Context) {
        }
    }
}

