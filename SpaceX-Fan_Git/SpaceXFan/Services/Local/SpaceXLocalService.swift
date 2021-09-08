//
//  SpaceXLocalService.swift
//  SpaceXFan
//
//  Created by kavin Soni on 02/09/21.
//

import Foundation

protocol SpaceXLocalServiceProtocol {
    func getRockets(completion: @escaping ((Result<[RocketInfo],Error>) -> Void))
    func getUpcomingLaunches(completion: @escaping ((Result<[UpcomingLaunches],Error>) -> Void))
    func getFavouriteRockets(completion: @escaping ((Result<[RocketInfo],Error>) -> Void))
    func toggleRocketFavouriteStatus(withId id:String) -> Bool
}

class SpaceXLocalService: BaseLocalService, SpaceXLocalServiceProtocol {
    func getFavouriteRockets(completion: @escaping ((Result<[RocketInfo], Error>) -> Void)) {
        do {
            var rockets:[RocketInfo] = try self.fetchAll()
            rockets.removeAll { rocket in
                rocket.isFavourite == false
            }
            completion(.success(rockets))
        } catch {
            completion(.failure(ServiceError.unimplementedError))
        }
    }
    func getRockets(completion: @escaping ((Result<[RocketInfo], Error>) -> Void)) {
        do {
            let rockets:[RocketInfo] = try self.fetchAll()
            completion(.success(rockets))
        } catch {
            completion(.failure(ServiceError.unimplementedError))
        }
    }
    
    func toggleRocketFavouriteStatus(withId id:String) -> Bool {
        do {
            let rocketInfo:RocketInfo = try self.fetch(byKey: "id", value: id)
            rocketInfo.isFavourite = !rocketInfo.isFavourite
            self.coreDataStack.saveContext()
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    func getUpcomingLaunches(completion: @escaping ((Result<[UpcomingLaunches], Error>) -> Void)) {
        completion(.failure(ServiceError.unimplementedError))
    }
    
//    func getFavouriteRockets(completion: @escaping ((Result<[RocketInfo], Error>) -> Void)) {
//        completion(.failure(ServiceError.unimplementedError))
//    }
}
