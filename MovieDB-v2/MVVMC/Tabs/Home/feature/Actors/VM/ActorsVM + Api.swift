//
//  ActorsVM + Api.swift
//  MovieDB-v2
//
//  Created by Imran on 11/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation

extension ActorsVM {
    
    func getActorDetails(for id: Int){
        APIClient.getArtistProfileId(id: id) { response, error in
            if let error = error {
                print(error)
                return
            }
            if let response = response {
                self.actorsData = response
                print(response)
            }
            DispatchQueue.main.async { [weak self] in
                self?.setupdata()
            }
        }
    }
    
    func getActorImageCell(for id: Int){
        APIClient.getPersonImageId(id: id) { (response, error) in
            if let error = error {
                print(error)
                return
            }
            if let response = response {
                self.actorProfileImage = response[0].profiles
             }
            DispatchQueue.main.async { [weak self] in
                self?.setupdata()
            }
        }
    }
    
    func getActorMovieCredit(for id: Int){
        APIClient.getPersonMovieCreditsId(id: id) { (response, error) in
            if let error = error {
                print(error)
                return
            }
            if let response = response {
                self.personCast = response[0].cast
            }
            DispatchQueue.main.async { [weak self] in
                self?.setupdata()
            }
        }
    }
}
