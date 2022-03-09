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
    weak var detailsDelegate: MovieDetilsProtocol?
    
    var onCompletion: Completion?
    
    private var movies: [Result]?
    private var rows: [TVRow] = []
    enum RowType: ItemType {
        case separator
        case topbar
    }
    
    deinit { Log.info() }
}
extension HomeVM {
    func LoadData(){
        fetchUpcomingCall()
        setupdata()
    }
    
    private func setupdata(){
        defer { delegate?.listUpdated(rows)}
        rows = []

        rows.append(TVRow(.separator, cell: SeparatorCell.separator(20, .clear)))
        rows.append(TVRow(.topbar, cell: MainTopbarTableCell()))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(20, .clear)))
        
        rows.append(TVRow(.topbar, cell: TitleBarTableCell()))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(12, .clear)))
        
        for _ in 0..<[movies].count {
            rows.append(TVRow(.topbar, cell: MovieCollectionTableCell(movie: movies ?? [], delegate: self)))
        }
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(40, .clear)))
      
        
    }
}
fileprivate extension TVRow {
    init(_ type: HomeVM.RowType, cell: UITableViewCell) {
        self.init(type: type, cell: cell)
    }
}

 
extension HomeVM: MovieDetilsProtocol {
   func setIndexPath(item: IndexPath) {
       print(item)
       onCompletion?()
   }
}
   
extension HomeVM {
    func fetchUpcomingCall(){
        APIClient.getAllMovieList(type: .upcoming) {[weak self] response, error in
            if let error = error {
                print(error)
                return
            }
            if let response = response {
                self?.movies = response[0].results ?? []
            }
            DispatchQueue.main.async { 
                self?.setupdata()
            }
        }
    }
}
