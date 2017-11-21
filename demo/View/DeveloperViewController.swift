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

class DeveloperViewController: UIViewController {
    
    let nameLabel = UILabel()
    
    let developerViewModel: DeveloperViewModel
    
    let disposeBag = DisposeBag()
    
    deinit {
        print("deinit DeveloperViewController")
    }
    
    init(developerViewModel: DeveloperViewModel) {
        self.developerViewModel = developerViewModel
        super.init(nibName: nil, bundle: nil)
        
        render()
        setupObservables()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        self.title = developerViewModel.developer.name
        nameLabel.text = developerViewModel.developer.name
        view.backgroundColor = .white
        nameLabel.textColor = .black
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupObservables() {
        developerViewModel.resourceMemoryLeak
            .asObservable()
            .subscribe(onNext: { [nameLabel] rand in // ZASTO?
                nameLabel.text = "\(rand)"
            }).disposed(by: disposeBag)
    }

}
