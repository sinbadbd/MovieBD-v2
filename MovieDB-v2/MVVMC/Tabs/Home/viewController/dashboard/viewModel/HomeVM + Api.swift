//
//  HomeVM + Api.swift
//  MovieDB-v2
//
//  Created by Imran on 10/3/22.
//  Copyright © 2022 portonics. All rights reserved.
//

import Foundation
import PromiseKit

extension HomeVM {
    func fetchUpcomingCall(for type: MovieUrlPath) -> Promise<[Result]>{
        return Promise { seal in
            APIClient.getAllMovieList(type: type) {[weak self] response, error in
                if let error = error {
                    print(error)
                    seal.reject(error)
//                    return
                }
                if let response = response {
                    self?.movies = response[0].results ?? []
                    seal.fulfill(response[0].results ?? [])
                }
                DispatchQueue.main.async {
                    self?.setupdata()
                }
            }
        }
    }
    
    func fetchNowPlayingCall(){
        APIClient.getAllMovieList(type: .nowPlaying) {[weak self] response, error in
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
    func fetchPopularCall(){
        APIClient.getAllMovieList(type: .popular) {[weak self] response, error in
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
    
    func fetchtopRatedCall(){
        APIClient.getAllMovieList(type: .topRated) {[weak self] response, error in
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
