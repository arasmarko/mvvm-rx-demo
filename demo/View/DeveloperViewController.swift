//
//  DeveloperViewController.swift
//  demo
//
//  Created by Marko Aras on 12/11/2017.
//  Copyright © 2017 MITURF. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

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
        let increaseCounterTaps = increaseCounterButton.rx
            .tapGesture()
            .when(UIGestureRecognizerState.recognized)
            .map({ _ -> Void in
                return
            })
        
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
        increaseCounterButton.titleLabel?.text = "+"
        
        view.addSubview(counterLabel)
        counterLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(increaseCounterButton)
        increaseCounterButton.backgroundColor = .red
        increaseCounterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(40)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // 1
    func setupObservables() {
        developerViewModel.counter
            .asObservable()
            .subscribe(onNext: { [counterLabel] counterValue in // ZASTO?
                counterLabel.text = "\(counterValue)"
            })
            .disposed(by: disposeBag)
    }
    
    // 2
//    func setupObservables() {
//        developerViewModel.counter
//            .map { return "\($0)" }
//            .drive(self.counterLabel.rx.text)
//            .disposed(by: disposeBag)
//    }


}
