//
//  UpcomingListViewModel.swift
//  SpaceXFan
//
//  Created by Kavin Soni on 03/09/21.
//

import UIKit


protocol UpcomingListViewModelInputProtocol {
    func fetchUpcomingRockets() -> Void
}

protocol UpcomingListViewModelOutputProtocol {
    func didReceive(rocketsInfo:[UpcomingLaunches]) -> Void
    func didFailToReceiveRocketsInfo(withError error:Error) -> Void
}


class UpcomingListViewModel: UpcomingListViewModelInputProtocol {
   
    
    private let spaceXRepository:SpaceXRepositoryProtocol
    
    private(set) var rockets:[UpcomingLaunches] = []
    private let output:UpcomingListViewModelOutputProtocol
    init(
        output:UpcomingListViewModelOutputProtocol,
        spaceXRepository:SpaceXRepositoryProtocol = SpaceXRepository()
    ) {
        self.spaceXRepository = spaceXRepository
        self.output = output
    }
    
    func fetchUpcomingRockets() {

        self.spaceXRepository.getUpcomingLaunches { result in
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
