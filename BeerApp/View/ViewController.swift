//
//  ViewController.swift
//  BeerApp
//
//  Created by Павел Градов on 31.10.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let beerManager: BeerManager
    private let interfaceManager: InterfaceManager
    
    private lazy var lightBeerTitleLabel: UILabel = interfaceManager.createTitleLabel(withText: "Old Boy")
    private lazy var lightBeerMinusButton: UIButton = interfaceManager.createOperatorButton(with: .minus)
    private lazy var lightBeerPlusButton: UIButton = interfaceManager.createOperatorButton(with: .plus)
    private lazy var lightBeerCounterLabel: UILabel = interfaceManager.createCounterLabel()
    private lazy var lightBeerHStackView: UIStackView = interfaceManager.createHStackView()
    private lazy var lightBeerVStackView: UIStackView = interfaceManager.createVStackView()
    
    private lazy var mediumBeerTitleLabel: UILabel = interfaceManager.createTitleLabel(withText: "Star Wars")
    private lazy var mediumBeerMinusButton: UIButton = interfaceManager.createOperatorButton(with: .minus)
    private lazy var mediumBeerPlusButton: UIButton = interfaceManager.createOperatorButton(with: .plus)
    private lazy var mediumBeerCounterLabel: UILabel = interfaceManager.createCounterLabel()
    private lazy var mediumBeerHStackView: UIStackView = interfaceManager.createHStackView()
    private lazy var mediumBeerVStackView: UIStackView = interfaceManager.createVStackView()
    
    private lazy var heavyBeerTitleLabel: UILabel = interfaceManager.createTitleLabel(withText: "True Man")
    private lazy var heavyBeerMinusButton: UIButton = interfaceManager.createOperatorButton(with: .minus)
    private lazy var heavyBeerPlusButton: UIButton = interfaceManager.createOperatorButton(with: .plus)
    private lazy var heavyBeerCounterLabel: UILabel = interfaceManager.createCounterLabel()
    private lazy var heavyBeerHStackView: UIStackView = interfaceManager.createHStackView()
    private lazy var heavyBeerVStackView: UIStackView = interfaceManager.createVStackView()
    
    private lazy var beersStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 30
        return $0
    }(UIStackView())
    
    private lazy var currentOrderLabel: UILabel = {
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20)
        $0.text = "Order is empty"
        $0.numberOfLines = 4
        return $0
    }(UILabel())
    
    private lazy var sellButton: UIButton = interfaceManager.createButton(
        withTitle: "Sell Beer",
        font: .systemFont(ofSize: 22, weight: .bold),
        textColor: .blue
    )
    
    private lazy var startDayButton: UIButton = interfaceManager.createButton(withTitle: "Start Day")
    
    private lazy var endDayButton: UIButton = interfaceManager.createButton(withTitle: "End Day")
    
    private lazy var buttonsStack: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    init(with beerManager: BeerManager, interfaceManager: InterfaceManager) {
        self.beerManager = beerManager
        self.interfaceManager = interfaceManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        [beersStackView, currentOrderLabel, buttonsStack].forEach {
            view.addSubview($0)
        }
        
        setupButtons()
        setupStacks()
        
        beersStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(90)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(300)
        }
        
        currentOrderLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.top.equalTo(beersStackView.snp.bottom).offset(40)
            $0.height.equalTo(120)
        }
        
        buttonsStack.snp.makeConstraints {
            $0.top.equalTo(currentOrderLabel.snp.bottom).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
    
    private func setupButtons() {
        lightBeerMinusButton.addTarget(self, action: #selector(lightBeerMinusButtonPressed), for: .touchUpInside)
        lightBeerPlusButton.addTarget(self, action: #selector(lightBeerPlusButtonPressed), for: .touchUpInside)
        
        mediumBeerMinusButton.addTarget(self, action: #selector(mediumBeerMinusButtonPressed), for: .touchUpInside)
        mediumBeerPlusButton.addTarget(self, action: #selector(mediumBeerPlusButtonPressed), for: .touchUpInside)
        
        heavyBeerMinusButton.addTarget(self, action: #selector(heavyBeerMinusButtonPressed), for: .touchUpInside)
        heavyBeerPlusButton.addTarget(self, action: #selector(heavyBeerPlusButtonPressed), for: .touchUpInside)
        
        sellButton.addTarget(self, action: #selector(sellBeerButtonPressed), for: .touchUpInside)
        startDayButton.addTarget(self, action: #selector(startDayButtonPressed), for: .touchUpInside)
        endDayButton.addTarget(self, action: #selector(endDayButtonPressed), for: .touchUpInside)
    }
    
    private func setupStacks() {
        [lightBeerMinusButton, lightBeerCounterLabel, lightBeerPlusButton].forEach { view in
            lightBeerHStackView.addArrangedSubview(view)
        }
        [lightBeerTitleLabel, lightBeerHStackView].forEach { view in
            lightBeerVStackView.addArrangedSubview(view)
        }
        
        [mediumBeerMinusButton, mediumBeerCounterLabel, mediumBeerPlusButton].forEach { view in
            mediumBeerHStackView.addArrangedSubview(view)
        }
        [mediumBeerTitleLabel, mediumBeerHStackView].forEach { view in
            mediumBeerVStackView.addArrangedSubview(view)
        }
        
        [heavyBeerMinusButton, heavyBeerCounterLabel, heavyBeerPlusButton].forEach { view in
            heavyBeerHStackView.addArrangedSubview(view)
        }
        [heavyBeerTitleLabel, heavyBeerHStackView].forEach { view in
            heavyBeerVStackView.addArrangedSubview(view)
        }
        
        [lightBeerVStackView, mediumBeerVStackView, heavyBeerVStackView].forEach { view in
            beersStackView.addArrangedSubview(view)
        }
        
        [sellButton, startDayButton, endDayButton].forEach { view in
            buttonsStack.addArrangedSubview(view)
        }
    }
    
    @objc private func lightBeerPlusButtonPressed() {
        beerManager.addBeer(beerType: .lightBeer)
        lightBeerCounterLabel.text = String(beerManager.currentOrder[0])
    }
    
    @objc private func lightBeerMinusButtonPressed() {
        beerManager.removeBeer(beerType: .lightBeer)
        lightBeerCounterLabel.text = String(beerManager.currentOrder[0])
    }
    
    @objc private func mediumBeerPlusButtonPressed() {
        beerManager.addBeer(beerType: .mediumBeer)
        mediumBeerCounterLabel.text = String(beerManager.currentOrder[1])
    }
    
    @objc private func mediumBeerMinusButtonPressed() {
        beerManager.removeBeer(beerType: .mediumBeer)
        mediumBeerCounterLabel.text = String(beerManager.currentOrder[1])
    }
    
    @objc private func heavyBeerPlusButtonPressed() {
        beerManager.addBeer(beerType: .heavyBeer)
        heavyBeerCounterLabel.text = String(beerManager.currentOrder[2])
    }
    
    @objc private func heavyBeerMinusButtonPressed() {
        beerManager.removeBeer(beerType: .heavyBeer)
        heavyBeerCounterLabel.text = String(beerManager.currentOrder[2])
    }
    
    @objc private func sellBeerButtonPressed() {
        currentOrderLabel.text = beerManager.sell()
        resetBeerCounters()
    }
    
    @objc private func startDayButtonPressed() {
        currentOrderLabel.text = beerManager.startDay()
        resetBeerCounters()
    }
    
    @objc private func endDayButtonPressed() {
        currentOrderLabel.text = beerManager.endDay()
        resetBeerCounters()
    }
    
    private func resetBeerCounters() {
        lightBeerCounterLabel.text = "0"
        mediumBeerCounterLabel.text = "0"
        heavyBeerCounterLabel.text = "0"
    }
}

