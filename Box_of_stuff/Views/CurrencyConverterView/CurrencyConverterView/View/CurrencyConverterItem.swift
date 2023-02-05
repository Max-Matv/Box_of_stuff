//
//  CurrencyConverterItem.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 2.12.22.
//

import UIKit

class CurrencyConverterItem: UIView {
    
    weak var delegate: CurrencyConverterViewItemDelegate?
    private var cornerRadius: Double = 20
    var buttonAction: (CurrencyConverterItem) -> Void = {_ in}
    private var cost: Double = 0 {
        didSet {
            redrawField()
        }
    }
    private var currency: String = "" {
        didSet {
            button.setTitle("\(currency) \(Symbols.getIcon(currency))", for: .normal)
            delegate?.CurrencyNameDidChange(self)
        }
    }
    private lazy var dynamicLayer = CAShapeLayer()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        textField.textColor = .white
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        setupLayer()
        setupBackground()
        redrawField()
    }
    
    private func redrawField() {
        let size = textField.text?.count ?? 0
        let width = caculate(size)
         let animation = CABasicAnimation(keyPath: "path")
         animation.fromValue = dynamicLayer.path
         let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: bounds.height), cornerRadius: cornerRadius)
         dynamicLayer.path = path.cgPath
         animation.toValue = path
         animation.duration = 0.2
         dynamicLayer.add(animation, forKey: "path")
    }
    
    private func caculate(_ size: Int) -> CGFloat {
        switch size {
        case 0...4 :
            return textField.bounds.width / 3
        case 5...6 :
            return textField.bounds.width / 2.3
        case 7...8 :
            return textField.bounds.width / 1.8
        case 9...10 :
            return textField.bounds.width / 1.5
        case 11...12 :
            return textField.bounds.width / 1.3
        case 13...14 :
            return textField.bounds.width / 1.1
        default:
            return textField.bounds.width
        }
    }
    
    private func setupBackground()  {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), cornerRadius: cornerRadius)
        path.lineWidth = 1
        UIColor(white: 0, alpha: 0.3).setStroke()
        UIColor(named: "mainColor")?.setFill()
        path.fill()
        path.stroke()
    }
    
    func setCurrency(_ currency: String) {
        self.currency = currency
    }
    
    func getCurrency() -> String {
        currency
    }
    
    func getCost() -> Double {
        cost
    }
    
    func setCost(_ cost: Double) {
        let value = String(format: "%.2f", cost)
        let valueArray = value.components(separatedBy: ".")
        if valueArray[1] == "00" {
            textField.text = valueArray[0]
        } else {
            textField.text = value
        }
        self.cost = cost
    }
    
    private func setupButton() {
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
    }
    
    @objc
    private func buttonPressed(_ sender: UIButton) {
        buttonAction(self)
    }
    
    private func setupLayer() {
        dynamicLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: textField.bounds.width / 3 , height: bounds.height), cornerRadius: cornerRadius)
        dynamicLayer.path = path.cgPath
        dynamicLayer.fillColor = UIColor(named: "rightSide")?.cgColor
        layer.insertSublayer(dynamicLayer, at: 0)
    }
    
    private func setupView() {
        let stackView: UIStackView = {
           let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(button)
        setupButton()
        textField.delegate = self
        let seporator = UIView()
        seporator.translatesAutoresizingMaskIntoConstraints = false
        seporator.backgroundColor = UIColor(white: 0, alpha: 0.3)
        textField.addSubview(seporator)
        NSLayoutConstraint.activate([
            seporator.widthAnchor.constraint(equalToConstant: 1),
            seporator.topAnchor.constraint(equalTo: textField.topAnchor, constant: 2),
            seporator.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2),
            seporator.trailingAnchor.constraint(equalTo: textField.trailingAnchor)
        ])
    }
   
}

extension CurrencyConverterItem: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        cost = Double(textField.text!) ?? 0
        delegate?.CurrencyDataDidChange(self)
    }
}
