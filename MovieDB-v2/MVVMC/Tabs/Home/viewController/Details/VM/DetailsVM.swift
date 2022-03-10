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

final class DetailsVM: MovieDetilsProtocol {
    func setIndexPath(item: Result) {
        
    }
    
    weak var delegate: DetailsVMVMDelegate?
    var onCompletion: Completion?
    
    public var movies: Result?
    public var casts: [MovieCast]?
    public var movieSimilar: [Result]?
    
    public var type: MovieUrlPath?

    private var rows: [TVRow] = []
    enum RowType: ItemType {
        case topBanner
        case caption
        case separator
        case imageContent
        case titleBar
        case cast
        case similar
    }
    
    init(movie: Result?){
        self.movies = movie
    }
    
    deinit { Log.info() }
}
extension DetailsVM {
    func LoadData(){
        setupdata()
        getPersionCall(for: movies?.id ?? 0)
        fetchSimilarCall(for: movies?.id ?? 0)
        fetchRecommandationCall(for: movies?.id ?? 0)
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
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(15, .clear)))
        
        rows.append(TVRow(.titleBar, cell: TitleBarTableCell.init(color: .orange, title: "Cast", seeAll: "See All")))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(10, .clear)))
        rows.append(TVRow.init(.cast, cell: MoviesCastTableCell(cast: casts)))
        
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(20, .clear)))
        rows.append(TVRow(.titleBar, cell: TitleBarTableCell.init(color: .orange, title: "More like this", seeAll: "See All")))
        rows.append(TVRow(.similar, cell: MovieCollectionTableCell(movie: movieSimilar ?? [], delegate: self)))
        
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(10, .clear)))
        rows.append(TVRow(.titleBar, cell: TitleBarTableCell.init(color: .orange, title: "Recommendation", seeAll: "See All")))
        rows.append(TVRow(.similar, cell: MovieCollectionTableCell(movie: movieSimilar ?? [], delegate: self)))

        rows.append(TVRow(.separator, cell: SeparatorCell.separator(10, .clear)))
        rows.append(TVRow(.titleBar, cell: TitleBarTableCell.init(color: .orange, title: "Vedio", seeAll: "See All")))
        
        
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(10, .clear)))
        rows.append(TVRow(.titleBar, cell: TitleBarTableCell.init(color: .orange, title: "Images", seeAll: "See All")))
        rows.append(TVRow(.separator, cell: SeparatorCell.separator(10, .clear)))
    }
}
fileprivate extension TVRow {
    init(_ type: DetailsVM.RowType, cell: UITableViewCell) {
        self.init(type: type, cell: cell)
    }
}
