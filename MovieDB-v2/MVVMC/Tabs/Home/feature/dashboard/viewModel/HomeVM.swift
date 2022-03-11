//
//  HomeViewModel.swift
//  MovieDB-v2
//
//  Created by Imran on 8/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit

protocol HomeVMVMDelegate: AnyObject {
    func listUpdated(_ list:[TVRow])
}

final class HomeVM {
    
    typealias MovieDetails = (_ movie: Result?) -> Void
    
    weak var delegate: HomeVMVMDelegate?
    weak var detailsDelegate: MovieDetilsProtocol?
    
    var onCompletion: MovieDetails? //Completion?
    
    public var movies: [Result]?
    public var type: MovieUrlPath?
    //    public var moviesNowPlaying: [Result]?
    //    public var moviespopular: [Result]?
    //    public var moviesTopRated: [Result]?
    
    private var rows: [TVRow] = []
    enum RowType: ItemType {
        case separator
        case topbar
        case upcoming
        case playing
        case popular
        case toprated
    }
    
    deinit { Log.info() }
}
extension HomeVM {
    func LoadData(){
        
        setupdata()

        firstly {
            self.fetchUpcomingCall(for: .upcoming)
        }.then { _ in
            self.fetchUpcomingCall(for: .nowPlaying)
        }.then { _ in
            self.fetchUpcomingCall(for: .popular)
        }.then { _ in
            self.fetchUpcomingCall(for: .topRated)
        }.done { _ in
            
        }.catch { error in
            print(error)
        }
    }
    
    public func setupdata(){
        defer { delegate?.listUpdated(rows)}
        rows = []
 
        topSearchBar()
        upcommingMovie()
        nowPlayingMovie()
        popularMovie()
        topRatedMovie()

    }
    func topSearchBar(){
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(20, .clear)))
        rows.append(TVRow(.topbar, cell: MainTopbarTableCell()))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(20, .clear)))
        
    }
    func upcommingMovie(){
        rows.append(TVRow(.topbar, cell: TitleBarTableCell.init(color: .red, title: "Upcomming Movies", seeAll: "See All")))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(12, .clear)))
        rows.append(TVRow(.upcoming, cell: MovieCollectionTableCell(movie: movies ?? [], delegate: self)))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(40, .clear)))
    }
    func nowPlayingMovie(){
        rows.append(TVRow(.topbar, cell: TitleBarTableCell.init(color: .green, title: "Now Playing Movies", seeAll: "See All")))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(12, .clear)))
        rows.append(TVRow(.playing, cell: MovieCollectionTableCell(movie: movies ?? [], delegate: self)))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(40, .clear)))
    }
    func popularMovie(){
        rows.append(TVRow(.topbar, cell: TitleBarTableCell.init(color: .blue, title: "Popular Movies", seeAll: "See All")))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(12, .clear)))
        rows.append(TVRow(.popular, cell: MovieCollectionTableCell(movie: movies ?? [], delegate: self)))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(40, .clear)))
    }
    func topRatedMovie(){
        rows.append(TVRow(.topbar, cell: TitleBarTableCell.init(color: .orange, title: "TopRated Movies", seeAll: "See All")))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(12, .clear)))
        rows.append(TVRow(.toprated, cell: MovieCollectionTableCell(movie: movies ?? [], delegate: self)))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(40, .clear)))
    }
}
fileprivate extension TVRow {
    init(_ type: HomeVM.RowType, cell: UITableViewCell) {
        self.init(type: type, cell: cell)
    }
}


extension HomeVM: MovieDetilsProtocol {
    func setIndexPath(item: Result) {
        onCompletion?(item)
    }
}

