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

        increaseCounterButton.rx
            .tap
            .asObservable()
            .subscribe(onNext: { tap in
                print("Tap")
                if let textInLabel = self.counterLabel.text,
                    let numberInLabel = Int(textInLabel) {
                    self.counterLabel.text = "\(numberInLabel+1)"
                }
            }).disposed(by: disposeBag)
        
        counterLabel.rx
            .observe(String.self, "text")
            .subscribe(onNext: { newText in
                guard let newText = newText else {
                    return
                }
                print("new text:", newText)
            }).disposed(by: disposeBag)
        
        render()
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
    
}
