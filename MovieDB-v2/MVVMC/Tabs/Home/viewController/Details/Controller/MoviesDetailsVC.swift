//
//  MoviesDetailsVC.swift
//  MovieDB-v2
//
//  Created by Imran on 9/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MoviesDetailsVC: UIViewController {

    var onBack: Completion?
    var titleBar =  TitleBar()
    let tableView = UITableView()
    let relayRows: BehaviorRelay<[TVRow]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()
    public var viewModel: DetailsVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        viewModel?.LoadData()
        setupUI()
        view.backgroundColor = UIColor.init(red: 238/255, green: 245/255, blue: 254/255, alpha: 1)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleBar.titleLabel.text = viewModel.movies?.title
        titleBar.onBackAction = onBack
    }
    
    func setupUI() {
        Log.info()
        view.addSubview(titleBar)
        titleBar.position(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        titleBar.size(height:40)
        titleBar.layer.zPosition = 1
        
        view.addSubview(tableView)
        tableView.position(top: titleBar.bottomAnchor, left: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.trailingAnchor, insets:  .init())
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
    }

}
extension MoviesDetailsVC: DetailsVMVMDelegate {
    func listUpdated(_ list: [TVRow]) {
        relayRows.accept(list)
    }
}
extension MoviesDetailsVC {
    // --------------------------------------
    // MARK: Private
    // --------------------------------------
    
    private func bindView() {
        relayRows.bind(to: tableView.rx.items) { (tv, row, item) -> UITableViewCell in
            return item.cell }.disposed(by: disposeBag)
    }
}
