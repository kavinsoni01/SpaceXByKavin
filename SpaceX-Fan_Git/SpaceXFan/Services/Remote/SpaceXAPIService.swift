//
//  SpaceXRemoteService.swift
//  SpaceXFan
//
//  Created by kavin Soni on 01/09/21.
//

import Foundation

protocol SpaceXAPIServiceProtocol:AnyObject {
    func getRockets(completion: @escaping ((Result<[RocketInfo],Error>) -> Void))
    func getUpcomingLaunches(completion: @escaping ((Result<[UpcomingLaunches],Error>) -> Void))
}

class SpaceXAPIService: BaseAPIService, SpaceXAPIServiceProtocol {
    func getUpcomingLaunches(completion: @escaping ((Result<[UpcomingLaunches], Error>) -> Void)) {
        self.get(url: endpoint(EndPoint.launchesUpcoming.rawValue), expectedModel: [UpcomingLaunches].self, completion: completion)
    }
    
    func getRockets(completion: @escaping ((Result<[RocketInfo], Error>) -> Void)) {
        self.get(url: endpoint(EndPoint.rockets.rawValue), expectedModel: [RocketInfo].self, completion: completion)
    }
    
    private enum EndPoint:String {
        case launchesUpcoming = "launches/upcoming"
        case rockets
    }
}
