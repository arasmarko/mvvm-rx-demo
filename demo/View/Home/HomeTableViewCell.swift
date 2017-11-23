//
//  HomeTableViewCell.swift
//  demo
//
//  Created by Marko Aras on 12/11/2017.
//  Copyright © 2017 MITURF. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeTableViewCell: UITableViewCell {
    
    var developer: Developer!
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfo(developer: Developer) {
        self.developer = developer
        self.textLabel?.text = developer.name
    }

}
