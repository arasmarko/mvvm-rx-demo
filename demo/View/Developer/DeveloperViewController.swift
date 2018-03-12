//
//  DeveloperViewController.swift
//  demo
//
//  Created by Marko Aras on 12/11/2017.
//  Copyright © 2017 MITURF. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class DeveloperViewController: UIViewController {
    
    let counterLabel = UILabel()
    let increaseCounterButton = UIButton()
    
    let developerViewModel: DeveloperViewModel
    
    let disposeBag = DisposeBag()
    
    deinit {
        print("deinit DeveloperViewController")
    }
    
    init(developerViewModel: DeveloperViewModel) {
        self.developerViewModel = developerViewModel
        super.init(nibName: nil, bundle: nil)
        let increaseCounterTaps = increaseCounterButton.rx.tap.asObservable()
        self.developerViewModel.setupIncreaseTaps(increaseCounterTaps: increaseCounterTaps)
        
        render()
        setupObservables()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        self.title = developerViewModel.developer.name
        view.backgroundColor = .white
        counterLabel.textColor = .black
        counterLabel.text = "\(developerViewModel.counterState)"
        increaseCounterButton.setTitle("+", for: .normal)
        increaseCounterButton.backgroundColor = .white
        increaseCounterButton.setTitleColor(UIColor.black, for: .normal)
        
        view.addSubview(counterLabel)
        counterLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(increaseCounterButton)
        increaseCounterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(40)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupObservables() {
        developerViewModel.counter
            .drive(self.counterLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}
