//
//  RocketInfo.swift
//  SpaceXFan
//
//  Created by kavin Soni on 01/09/21.
//

import Foundation
import CoreData

// MARK: - RocketInfo
@objc(RocketInfo)
class RocketInfo:NSManagedObject, Codable {
    @NSManaged var  flickrImages: [String]
    @NSManaged var  name: String
    @NSManaged var  type: String
    @NSManaged var  active: Bool
    @NSManaged var  stages: Int16
    @NSManaged var  boosters: Int16
    @NSManaged var  costPerLaunch: Int64
    @NSManaged var  successRatePct: Int16
    @NSManaged var  firstFlight: String
    @NSManaged var  country: String
    @NSManaged var  company: String
    @NSManaged var  wikipedia: String
    @NSManaged var  rocketInfoDescription: String
    @NSManaged var  id: String
    @NSManaged var  isFavourite: Bool

    enum CodingKeys: String, CodingKey {
        case flickrImages = "flickr_images"
        case name = "name"
        case type = "type"
        case active = "active"
        case stages = "stages"
        case boosters = "boosters"
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country = "country"
        case company = "company"
        case wikipedia = "wikipedia"
        case rocketInfoDescription = "description"
        case id = "id"
        case isFavourite
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard
            let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "RocketInfo", in: managedObjectContext)
        else {
            fatalError("decode failure")
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.flickrImages = try container.decodeIfPresent([String].self, forKey: .flickrImages) ?? []
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.firstFlight = try container.decodeIfPresent(String.self, forKey: .firstFlight) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.wikipedia = try container.decodeIfPresent(String.self, forKey: .wikipedia) ?? ""
        self.rocketInfoDescription = try container.decodeIfPresent(String.self, forKey: .rocketInfoDescription) ?? ""
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.active = try container.decodeIfPresent(Bool.self, forKey: .active) ?? false
        self.stages = try container.decodeIfPresent(Int16.self, forKey: .stages) ?? -1
        self.boosters = try container.decodeIfPresent(Int16.self, forKey: .boosters) ?? -1
        self.costPerLaunch = try container.decodeIfPresent(Int64.self, forKey: .costPerLaunch) ?? -1
        self.successRatePct = try container.decodeIfPresent(Int16.self, forKey: .successRatePct) ?? -1
        self.isFavourite = try container.decodeIfPresent(Bool.self, forKey: .active) ?? false
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(flickrImages , forKey: .flickrImages)
            try container.encode(name , forKey: .name)
            try container.encode(type , forKey: .type)
            try container.encode(firstFlight , forKey: .firstFlight)
            try container.encode(country , forKey: .country)
            try container.encode(wikipedia , forKey: .wikipedia)
            try container.encode(rocketInfoDescription , forKey: .rocketInfoDescription)
            try container.encode(id , forKey: .id)
            try container.encode(active , forKey: .active)
            try container.encode(stages , forKey: .stages)
            try container.encode(boosters , forKey: .boosters)
            try container.encode(costPerLaunch , forKey: .costPerLaunch)
            try container.encode(successRatePct , forKey: .successRatePct)
            try container.encode(isFavourite, forKey: .isFavourite)
        } catch {
            print("error")
        }
    }
}
 
