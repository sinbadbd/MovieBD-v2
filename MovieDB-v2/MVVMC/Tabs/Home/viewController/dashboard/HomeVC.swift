//
//  HomeVC.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class HomeVC: UIViewController, Reusable {
    
    let tableView = UITableView()
    
    let relayRows: BehaviorRelay<[TVRow]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()
    
    public var viewModel: HomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.info()
        view.backgroundColor = .white
        bindView()
        viewModel?.LoadData()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Log.info()
        self.navigationController?.navigationBar.topItem?.title = "Movies"

    }
    
    func setupUI() {
        Log.info()
      
        view.addSubview(tableView)
        tableView.fitToSuper()
        tableView.separatorStyle = .none
      
     }
    
    deinit { Log.info() }
    
}
extension HomeVC: HomeVMVMDelegate {
    func listUpdated(_ list: [TVRow]) {
        relayRows.accept(list)
    }
}

extension HomeVC {
    // --------------------------------------
    // MARK: Private
    // --------------------------------------
    
    private func bindView() {
        relayRows.bind(to: tableView.rx.items) { (tv, row, item) -> UITableViewCell in
            return item.cell }.disposed(by: disposeBag)
    }
}
