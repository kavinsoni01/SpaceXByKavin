//
//  RocketsListViewModel.swift
//  SpaceXFan
//
//  Created by kavin Soni on 02/09/21.
//

import Foundation

protocol RocketListViewModelInputProtocol {
    func fetchRockets() -> Void
    func fetchFavouriteRockets() -> Void 
    func toggleFavouriteStatus(rocketId:String)->Void
}

protocol RocketListViewModelOutputProtocol {
    func didReceive(rocketsInfo:[RocketInfo]) -> Void
    func didFailToReceiveRocketsInfo(withError error:Error) -> Void
}


class RocketsListViewModel: RocketListViewModelInputProtocol {
   
    
    private let spaceXRepository:SpaceXRepositoryProtocol
    
    private(set) var rockets:[RocketInfo] = []
    private let output:RocketListViewModelOutputProtocol
    init(
        output:RocketListViewModelOutputProtocol,
        spaceXRepository:SpaceXRepositoryProtocol = SpaceXRepository()
    ) {
        self.spaceXRepository = spaceXRepository
        self.output = output
    }
    
    //Toggle favorite in local data
    func toggleFavouriteStatus(rocketId:String) -> Void {
        self.spaceXRepository.toggleRocketFavouriteStatus(withId: rocketId)
    }
    
    
    //Fetch rocket offline
    func fetchRocketsOffline() -> Void {
        self.spaceXRepository.getRockets { result in
            switch result {
                case .success(let rocketsInfo):
                    self.rockets = rocketsInfo
                    self.output.didReceive(rocketsInfo: rocketsInfo)

                case .failure(let error):
                    self.output.didFailToReceiveRocketsInfo(withError: error)
            }
        }
    }
    
    //fetch rocket favourite
    func fetchFavouriteRockets() -> Void {
            self.spaceXRepository.getFavouriteRockets{ result in
                switch result {
                    case .success(let rocketsInfo):
                        self.rockets = rocketsInfo
                        self.output.didReceive(rocketsInfo: rocketsInfo)
    
                    case .failure(let error):
                        self.output.didFailToReceiveRocketsInfo(withError: error)
                }
            }
    }
    
    //fetch rocket list
    func fetchRockets() -> Void {

        self.spaceXRepository.getRockets { result in
            switch result {
                case .success(let rocketsInfo):
                    self.rockets = rocketsInfo
                    self.output.didReceive(rocketsInfo: rocketsInfo)

                case .failure(let error):
                    self.output.didFailToReceiveRocketsInfo(withError: error)
            }
        }
    }
}
