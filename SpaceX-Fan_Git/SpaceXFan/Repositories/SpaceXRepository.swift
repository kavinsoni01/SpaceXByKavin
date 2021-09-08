//
//  SpaceXRepository.swift
//  SpaceXFan
//
//  Created by kavin Soni on 01/09/21.
//

import Foundation

protocol SpaceXRepositoryProtocol:AnyObject {
    func getRockets(completion: @escaping ((Result<[RocketInfo],Error>) -> Void))
    func getFavouriteRockets(completion: @escaping ((Result<[RocketInfo],Error>) -> Void))

    func getUpcomingLaunches(completion: @escaping ((Result<[UpcomingLaunches],Error>) -> Void))
    @discardableResult
    func toggleRocketFavouriteStatus(withId id:String) -> Bool
}

class SpaceXRepository: SpaceXRepositoryProtocol {
    
    private let remoteDataSource:SpaceXAPIServiceProtocol
    private let localDataSource:SpaceXLocalServiceProtocol
    
    init(
        remoteDataSource:SpaceXAPIServiceProtocol = SpaceXAPIService(),
        localDataSource:SpaceXLocalServiceProtocol = SpaceXLocalService()
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    //Get Rocket List
    func getRockets(completion: @escaping ((Result<[RocketInfo], Error>) -> Void)) {
        self.localDataSource.getRockets { result in
            switch result {
                case .success(let rockets):
                    if rockets.isEmpty {
                        //If rocket empty then fetch from remote data
                        self.remoteDataSource.getRockets(completion: completion)
                    } else {
                        completion(.success(rockets))
                    }
                case .failure:
                    //If rocket empty then fetch from remote data
                    self.remoteDataSource.getRockets(completion: completion)
            }
        }
    }
    
    //Get favourite Rockets
    func getFavouriteRockets(completion: @escaping ((Result<[RocketInfo], Error>) -> Void)) {
        self.localDataSource.getFavouriteRockets { result in
            switch result {
                case .success(let rockets):
                    completion(.success(rockets))
                case .failure:
                    self.remoteDataSource.getRockets(completion: completion)
            }
        }
    }
    
   
    //toggle rocket status
    func toggleRocketFavouriteStatus(withId id:String) -> Bool {
         self.localDataSource.toggleRocketFavouriteStatus(withId: id)
    }
    
    //get upcoming launches 
    func getUpcomingLaunches(completion: @escaping ((Result<[UpcomingLaunches], Error>) -> Void)) {
        self.localDataSource.getUpcomingLaunches { result in
            switch result {
                case .success(let upcomingLaunches):
                    completion(.success(upcomingLaunches))
                case .failure:
                    self.remoteDataSource.getUpcomingLaunches(completion: completion)
            }
        }
    }
}
