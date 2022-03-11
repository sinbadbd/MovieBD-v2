//
//  DetailsVM + Api.swift
//  MovieDB-v2
//
//  Created by Imran on 10/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation

extension DetailsVM {
    
    func getPersionCall(for movieId: Int){
        APIClient.getMovieCreditsId(id: movieId) { response, error in
            if let error = error {
                print(error)
                return
            }
            if let response = response {
                self.casts = response[0].cast
                print(response[0].cast as Any)
            }
            DispatchQueue.main.async {[weak self]  in
                self?.setupdata()
            }
        }
    }
    
    func fetchSimilarCall(for movieId: Int){
        APIClient.getMovieSimilarId(id: movieId) {[weak self] response, error in
            if let error = error {
                print(error)
                return
            }
            if let response = response {
                self?.movieSimilar = response[0].results ?? []
            }
            DispatchQueue.main.async {
                self?.setupdata()
            }
        }
    }
    func fetchRecommandationCall(for movieId: Int){
        APIClient.getMovieRecommandationId(id: movieId) {[weak self] response, error in
            if let error = error {
                print(error)
                return
            }
            if let response = response {
                self?.movieSimilar = response[0].results ?? []
            }
            DispatchQueue.main.async {
                self?.setupdata()
            }
        }
    }
    
    func getMovieVedioCall(for movieId: Int){
        APIClient.getMovieVideoId(id: movieId) { [weak self] (response, error) in
            if let response = response {
                print("VEDIO LIST: \(response)")
                self?.vedioList = response[0].results ?? []
            }
        }
        DispatchQueue.main.async {[weak self] in
            self?.setupdata()
        }
    }
    
    func getMovieImageCall(for movieId: Int){
        APIClient.getMovieImageId(id:movieId) { [weak self] (response, error) in
            if let response = response {
                print("Image LIST: \(response)")
                self?.backdrop = response[0].posters
            }
            DispatchQueue.main.async {[weak self] in
                self?.setupdata()
            }
        }
    }
}
