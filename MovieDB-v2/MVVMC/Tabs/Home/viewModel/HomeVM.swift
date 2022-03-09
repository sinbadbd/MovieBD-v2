//
//  HomeViewModel.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation
import UIKit


protocol HomeVMVMDelegate: AnyObject {
    func listUpdated(_ list:[TVRow])
}

final class HomeVM {
    weak var delegate: HomeVMVMDelegate?
    private var rows: [TVRow] = []
    enum RowType: ItemType {
        case separator
        case topbar
    }
    
    deinit { Log.info() }
}
extension HomeVM {
    func LoadData(){
        setupdata()
    }
    
    private func setupdata(){
        defer { delegate?.listUpdated(rows)}
        rows = []
        
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(20, .clear)))
        rows.append(TVRow(.topbar, cell: MainTopbarTableCell()))

    }
}
fileprivate extension TVRow {
    init(_ type: HomeVM.RowType, cell: UITableViewCell) {
        self.init(type: type, cell: cell)
    }
}

 
