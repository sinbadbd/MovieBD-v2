//
//  ActorsVM + UI.swift
//  MovieDB-v2
//
//  Created by Imran on 11/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation

extension ActorsVM {
    public func setActorUICall() {
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(10, .clear)))
        rows.append(TVRow(type: DetailsVM.RowType.caption, cell: CaptionTitleActorCell(actor: actorsData)))
        rows.append(TVRow(type: DetailsVM.RowType.separator, cell: SeparatorCell.separator(15, .clear)))
    }
    
    func setActorSliderUICall(){
        rows.append(TVRow(type: DetailsVM.RowType.caption, cell: ActorImageSliderTableCell(profileImg: actorProfileImage ?? [])))
    }
    func setActorDetailsUI(){
        rows.append(TVRow(type: DetailsVM.RowType.caption, cell: ActorImageTitleTableCell(artist: actorsData)))
    }
    
 
    func setMovieCredit(){
        rows.append(TVRow(type: DetailsVM.RowType.caption, cell: ActorMovieCreditsCell(actorMovieCredit: personCast, delegate: self)))
    }

//    MovieCollectionTableCell
    
    
}
