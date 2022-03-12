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
 
    typealias MovieDetails = (_ movie: Result?) -> Void
    typealias MovieCastsActor = (_ movie: MovieCast?) -> Void
    
    var onCompletion: MovieDetails?
    var onCompletionMovieCast: MovieCastsActor?
    
    weak var delegate: DetailsVMVMDelegate?
    weak var castDelegate: MovieCastProtocol?
    
    public var movies: Result?
    public var casts: [MovieCast]?
    public var movieSimilar: [Result]?
    public var vedioList: [VideoResult]?
    public var backdrop : [Backdrop]?
    public var type: MovieUrlPath?
    
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
    
    init(movie: Result?){
        self.movies = movie
    }
    
    deinit { Log.info() }
}

extension DetailsVM {
    
    /// Load
    func LoadData(){
        setupdata()
        apiCalls()
    }
    
    /// setup ui
    public func setupdata(){
        defer { delegate?.listUpdated(rows)}
        rows = []
        allUICalls()
    }
    
    /// api call
    private func apiCalls(){
        getPersionCall(for: movies?.id ?? 0)
        fetchSimilarCall(for: movies?.id ?? 0)
        fetchRecommandationCall(for: movies?.id ?? 0)
        getMovieVedioCall(for: movies?.id ?? 0)
        getMovieImageCall(for: movies?.id ?? 0)
    }
    
    /// all ui
    private func allUICalls(){
        setBannerImageCall()
        setCaptionTitleCall()
        setImageCall()
        setWishButton()
        setMovieRattingCall()
        setMovieCastCall()
        setSimilarMovieCall()
        setRecommentMovieCall()
        if vedioList?.count ?? 0 > 0 {
            setVedioCall()
        }
        setMovieImageCall()
    }
}

fileprivate extension TVRow {
    init(_ type: DetailsVM.RowType, cell: UITableViewCell) {
        self.init(type: type, cell: cell)
    }
}

extension DetailsVM: MovieDetilsProtocol {
    func setIndexPath(item: Result) {
        onCompletion?(item)
    }
}

extension DetailsVM: MovieCastProtocol {
    func setIndexPath(item: MovieCast) {
        Log.debug(item)
        onCompletionMovieCast?(item)
    }
}
