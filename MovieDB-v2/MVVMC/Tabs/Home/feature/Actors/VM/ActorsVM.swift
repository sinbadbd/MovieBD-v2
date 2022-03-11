//
//  ActorsVM.swift
//  MovieDB-v2
//
//  Created by Imran on 11/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import UIKit

protocol ActorsVMVMDelegate: AnyObject {
    func listUpdated(_ list:[TVRow])
}

final class ActorsVM {
 
//    typealias MovieDetails = (_ movie: Result?) -> Void
//    var onCompletion: MovieDetails?
    weak var delegate: ActorsVMVMDelegate?
 
//    public var movies: Result?
      public var casts: [MovieCast]?
      public var movieCast: MovieCast?
    
//    public var movieSimilar: [Result]?
//    public var vedioList: [VideoResult]?
//    public var backdrop : [Backdrop]?
//    public var type: MovieUrlPath?
    
    var rows: [TVRow] = []
    
    enum RowType: ItemType {
        case topBanner
        case caption
        case separator
        case imageContent
        case titleBar
        case cast
        case similar
    }
    
    init(cast: MovieCast?){
        self.movieCast = cast
    }
    
    deinit { Log.info() }
}

extension ActorsVM {
    
    func LoadData(){
        setupdata()
        apiCalls()
    }
    
    public func setupdata(){
        defer { delegate?.listUpdated(rows)}
        rows = []
        allUICalls()
    }
    
    private func apiCalls(){
 
    }
    
    private func allUICalls(){
 
    }
}

fileprivate extension TVRow {
    init(_ type: ActorsVM.RowType, cell: UITableViewCell) {
        self.init(type: type, cell: cell)
    }
}
