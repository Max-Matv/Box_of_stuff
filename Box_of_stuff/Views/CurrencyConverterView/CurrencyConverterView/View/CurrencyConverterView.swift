//
//  CurrencyConverterView.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 29.11.22.
//

import UIKit

class CurrencyConverterView: UIView {

    weak var delegate: CurrencyConverterViewDelegate?
    private var content: [String: Double] = [:]
    private var currencyList: [String] = []
    private var currencyItems: [CurrencyConverterItem] = []
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var scrollView: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var deleteButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = UIColor(named: "rightSide")
        view.setTitle("-", for: .normal)
        view.dropShadow()
        return view
    }()
    let addButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.backgroundColor = UIColor(named: "add")
        view.dropShadow()
        view.setTitle("+", for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        registerForKeyboardNotifications()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        registerForKeyboardNotifications()
    }
    func testFunc() {
        let view = CurrencyConverterItem(frame: .zero)
        view.setCurrency("USD")
        stackView.addArrangedSubview(view)
        view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        view.delegate = self
        view.buttonAction = { sender in
            self.delegate?.CurrencyViewButtonPressed(sender)
        }
    }
    
    func getCurrencyList() -> [String] {
        currencyList
    }
    
    func setup(currency: Currency) {
        content = currency.rates
        content["USD"] = 1
        print(content)
        self.currencyList = [String](content.keys)
        elementPresetting()
    }
   
    private func recalculateConstraint() {
        stackView.axis = .vertical
        stackView.spacing = 15
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40)
        ])
    }
    private func animateElement(_ sender: UIView) {
        UIView.animate(withDuration: 0.2, delay: 0) {
            sender.alpha = 0.5
        } completion: { _ in
            sender.alpha = 1
        }
    }
    
    private func setupControlButtons() {
        scrollView.addSubview(deleteButton)
        scrollView.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            deleteButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.2),
            addButton.widthAnchor.constraint(equalTo: deleteButton.widthAnchor),
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            addButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -10)
        ])
    }
    @objc
    private func deleteButtonPressed(_ sender: UIButton) {
        animateElement(sender)
        if currencyItems.count > 2 {
            currencyItems.last!.removeFromSuperview()
            UIView.animate(withDuration: 0.2) {
                self.scrollView.layoutIfNeeded()
            }
            currencyItems.removeLast()
        }
    }
    
    @objc
    private func addButtonPressed(_ sender: UIButton) {
        animateElement(sender)
        for item in currencyList {
            if !matchChecking(item) {
                let view = CurrencyConverterItem()
                currencyItems.append(view)
                stackView.addArrangedSubview(view)
                UIView.animate(withDuration: 0.3) {
                    self.scrollView.layoutIfNeeded()
                }
                view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
                view.heightAnchor.constraint(equalToConstant: 60).isActive = true
                view.setCurrency(item)
                view.delegate = self
                view.buttonAction = { sender in
                    self.delegate?.CurrencyViewButtonPressed(sender)
                }
                let newValue = (content["USD"]! / content[currencyItems.first!.getCurrency()]!) / (content["USD"]! / content[view.getCurrency()]!) * currencyItems.first!.getCost()
                view.setCost(newValue)
                break
            }
        }
    }
    
    private func matchChecking(_ currencyName: String) -> Bool {
        var isChecked = false
        for item in currencyItems {
            if item.getCurrency()  == currencyName {
                isChecked = true
            }
        }
        return isChecked
    }
    
    private func setupView() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        scrollView.addSubview(stackView)
        recalculateConstraint()
        setupControlButtons()
    }
    
    private func elementPresetting() {
        let array = ["USD", "EUR"]
        for i in array {
            let view = CurrencyConverterItem(frame: .zero)
            currencyItems.append(view)
            stackView.addArrangedSubview(view)
            view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            view.heightAnchor.constraint(equalToConstant: 60).isActive = true
            view.setCurrency(i)
            view.setCost(content[i] ?? 0)
            view.delegate = self
            view.buttonAction = { sender in
                self.delegate?.CurrencyViewButtonPressed(sender)
            }
        }
    }
}

extension CurrencyConverterView: CurrencyConverterViewItemDelegate {
    func CurrencyNameDidChange(_ sender: CurrencyConverterItem) {
        var item = CurrencyConverterItem()
        if sender != currencyItems.first! {
            item = currencyItems.first!
        } else {
            item = currencyItems.last!
        }
        let newValue = (content["USD"]! / content[item.getCurrency()]!) / (content["USD"]! / content[sender.getCurrency()]!) * item.getCost()
        sender.setCost(newValue)
    }
    
    func CurrencyDataDidChange(_ sender: CurrencyConverterItem) {
        recalculateData(sender)
    }
}

extension CurrencyConverterView {
    private func recalculateData(_ activeSender: CurrencyConverterItem) {
        for currencyItem in currencyItems {
            if currencyItem != activeSender {
                let newValue = (content["USD"]! / content[activeSender.getCurrency()]!) / (content["USD"]! / content[currencyItem.getCurrency()]!) * activeSender.getCost()
                currencyItem.setCost(newValue)
            }
        }
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            self.scrollView.contentInset = .zero
        }
    }
}
