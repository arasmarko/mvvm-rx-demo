
//
//  CustomRefreshControllTableView.swift
//  demo
//
//  Created by Marko Aras on 18/11/2017.
//  Copyright © 2017 MITURF. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SnapKit

class CustomRefreshControllTableView: UITableView {
    var loader: UIImageView = UIImageView()
    var images: [UIImage]!
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.rx.contentOffset.startWith(CGPoint.zero)
            .subscribe(onNext: { [weak self] point in
                guard let `self` = self else {
                    return
                }
                if point.y < 0 {
                    let position = Double(point.y) * -1
                    if position < 100 && !self.loader.isAnimating && self.images.count > Int(position/1.44) {
                        self.loader.image = self.images[Int(position/1.44)]
                    }
                }
            }).disposed(by: disposeBag)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.clear
        self.refreshControl?.tintColor = UIColor.clear
        
        self.addCustomLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindRefreshing(isRefreshing: Variable<Bool>) {
        
        isRefreshing
            .asObservable()
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { load in
                if load {
                    self.setContentOffset(CGPoint.init(x: 0, y: (self.loader.bounds.height + 20) * -1) , animated: true)
                    self.refreshControl!.beginRefreshing()
                } else {
                    self.refreshControl!.endRefreshing()
                }
            }).disposed(by: disposeBag)
        
        isRefreshing
            .asDriver()
            .distinctUntilChanged()
            .drive(self.loader.rx.isAnimating)
            .disposed(by: disposeBag)
        
    }
    
    private func addCustomLoader() {
        self.images = []
        for i in 0...85 {
            images.append(UIImage(named: "Comp 2_000\(String(format: "%02d", i))")!)
        }
        loader.contentMode = .scaleAspectFit
        loader.animationImages = images
        loader.animationDuration = 1.5
        self.refreshControl?.addSubview(loader)
        loader.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }

    }
    
}

