//
//  HomeViewController.swift
//  demo
//
//  Created by Marko Aras on 11/11/2017.
//  Copyright © 2017 MITURF. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import RxGesture

struct DevelopersSection {
    var header: String
    var items: [Item]
}
extension DevelopersSection: SectionModelType {
    typealias Item = Developer
    
    init(original: DevelopersSection, items: [Item]) {
        self = original
        self.items = items
    }
}

class HomeViewController: UIViewController {
    let searchTextField = UITextField()
    
    let resultsTableView = CustomRefreshControllTableView(frame: .zero, style: .plain)
    var dataSource: RxTableViewSectionedReloadDataSource<DevelopersSection>!
    let cellReuseIdentifier = "HomeTableViewCell"
    
    var homeViewModel: HomeViewModel!
    let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        render()
        let refreshControlDriver = resultsTableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .map { _ -> String in
                return self.searchTextField.text ?? ""
            }.asDriver(onErrorJustReturn: "")
        
        homeViewModel = HomeViewModel(searchInput: searchTextField.rx.text.orEmpty.asDriver(), refreshControlDriver: refreshControlDriver)
        setupTableView()
        setupObservables()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        searchTextField.placeholder = "Search Developers"
        self.title = "Search Developers"
        view.backgroundColor = .white
        view.addSubview(searchTextField)
        searchTextField.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        searchTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(88)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(60)
        }
        
        view.addSubview(resultsTableView)
        resultsTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(148)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupTableView() {
        resultsTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        resultsTableView.estimatedRowHeight = 120
        resultsTableView.rowHeight = 120
        dataSource = RxTableViewSectionedReloadDataSource<DevelopersSection>(configureCell: { [weak self] (dataSource, tableView, indexPath, item) in
            guard let `self` = self else {
                return UITableViewCell()
            }
            let cell = self.resultsTableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! HomeTableViewCell
            cell.setupInfo(developer: item)
            cell.selectionStyle = .none
            
            return cell
        })
        
        resultsTableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in 
                guard let `self` = self else {
                    return
                }
                guard let cell = self.resultsTableView.cellForRow(at: indexPath) as? HomeTableViewCell, let dev = cell.developer else {
                    return
                }
                let devVM = DeveloperViewModel(developer: dev)
                let devVC = DeveloperViewController(developerViewModel: devVM)
                self.navigationController?.pushViewController(devVC, animated: true)
            }).disposed(by: disposeBag)
        
    }
    
}

// MARK: - Observables
extension HomeViewController {
    func setupObservables() {
        homeViewModel.developers
            .drive(self.resultsTableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        resultsTableView.bindRefreshing(isRefreshing: homeViewModel.isRefreshing)
    }
}
