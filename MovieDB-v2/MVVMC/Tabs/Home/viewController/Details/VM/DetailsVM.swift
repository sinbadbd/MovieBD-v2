//
//  DetailsVM.swift
//  MovieDB-v2
//
//  Created by Imran on 10/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//
 
import UIKit
import PromiseKit


protocol DetailsVMVMDelegate: AnyObject {
    func listUpdated(_ list:[TVRow])
}

final class DetailsVM {
    weak var delegate: DetailsVMVMDelegate?
    var onCompletion: Completion?
    
    public var movies: Result?
    public var type: MovieUrlPath?

    private var rows: [TVRow] = []
    enum RowType: ItemType {
        case topBanner
        case caption
        case separator
        case imageContent
    }
    
    init(movie: Result?){
        self.movies = movie
    }
    
    deinit { Log.info() }
}
extension DetailsVM {
    func LoadData(){
        setupdata()
    }
    
    public func setupdata(){
        defer { delegate?.listUpdated(rows)}
        rows = []
 
        rows.append(TVRow.init(.topBanner, cell: BannerImageCell(movie: movies)))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(10, .clear)))
        rows.append(TVRow.init(.caption, cell: CaptionCell(movie: movies)))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(10, .clear)))
        rows.append(TVRow.init(.imageContent, cell: ImageWithContentCell(movie: movies)))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(20, .clear)))
        rows.append(TVRow.init(.imageContent, cell: WishListButtonCell()))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(15, .clear)))
        rows.append(TVRow.init(.caption, cell: MovieRatingScoreCell(movie: movies)))

    }
}
fileprivate extension TVRow {
    init(_ type: DetailsVM.RowType, cell: UITableViewCell) {
        self.init(type: type, cell: cell)
    }
}
