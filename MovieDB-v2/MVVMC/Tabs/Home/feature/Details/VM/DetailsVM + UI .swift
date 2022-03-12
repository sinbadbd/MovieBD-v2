//
//  DetailsVM + UI .swift
//  MovieDB-v2
//
//  Created by Imran on 11/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation


extension DetailsVM {
    func setBannerImageCall() {
        rows.append(TVRow.init(type: DetailsVM.RowType.topBanner, cell: BannerImageCell(movie: movies)))
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(10, .clear)))
    }
    
    func setCaptionTitleCall() {
        rows.append(TVRow.init(type: DetailsVM.RowType.caption, cell: CaptionCell(movie: movies)))
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(10, .clear)))
    }
    
    func setImageCall() {
        rows.append(TVRow.init(type: DetailsVM.RowType.imageContent, cell: ImageWithContentCell(movie: movies)))
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(20, .clear)))
    }
    
    func setWishButton(){
        rows.append(TVRow.init(type: DetailsVM.RowType.imageContent, cell: WishListButtonCell()))
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(15, .clear)))
    }
    func setMovieRattingCall() {
        rows.append(TVRow.init(type: DetailsVM.RowType.caption, cell: MovieRatingScoreCell(movie: movies)))
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(15, .clear)))
    }
    
    func setMovieCastCall() {
        rows.append(TVRow(type: DetailsVM.RowType.titleBar, cell: TitleBarTableCell.init(color: .orange, title: "Cast", seeAll: "See All")))
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(10, .clear)))
        rows.append(TVRow.init(type: DetailsVM.RowType.cast, cell: MoviesCastTableCell(cast: casts, delegate: self)))
    }
    
    func setSimilarMovieCall(){
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(20, .clear)))
        rows.append(TVRow(type: DetailsVM.RowType.titleBar, cell: TitleBarTableCell.init(color: .orange, title: "More like this", seeAll: "See All")))
        rows.append(TVRow(type: DetailsVM.RowType.similar, cell: MovieCollectionTableCell(movie: movieSimilar ?? [], delegate: self)))
    }
    
    func setRecommentMovieCall(){
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(20, .clear)))
        rows.append(TVRow(type: DetailsVM.RowType.titleBar, cell: TitleBarTableCell.init(color: .orange, title: "Recommendation", seeAll: "See All")))
        rows.append(TVRow(type: DetailsVM.RowType.similar, cell: MovieCollectionTableCell(movie: movieSimilar ?? [], delegate: self)))
    }
    
    func setVedioCall(){
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(20, .clear)))
        rows.append(TVRow(type: DetailsVM.RowType.titleBar, cell: TitleBarTableCell.init(color: .orange, title: "Vedio", seeAll: "See All")))
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(15, .clear)))
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: MovieVedioListViewCell(vedioList: vedioList ?? [])))
    }
    
    func setMovieImageCall(){
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(10, .clear)))
        rows.append(TVRow(type: DetailsVM.RowType.titleBar, cell: TitleBarTableCell.init(color: .orange, title: "Images", seeAll: "See All")))
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: MovieImageListCell(vedioImageList: backdrop ?? [])))
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(10, .clear)))
    }
}
