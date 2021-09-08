import Foundation
import CoreData

struct UpcomingLaunches: Codable {
    let links: Links
    let net: Bool
    let window: Int?
    let rocket: String?
    let details: String?
    let crew: [String]
    let ships: [String]
    let capsules: [String]
    let payloads: [String]
    let launchpad: String
    let flightNumber: Int
    let name: String
    let dateutc: String
    let dateUnix: Int
    let dateLocal: Date
    let datePrecision: String
    let upcoming: Bool
    let cores: [Core]
    let autoUpdate: Bool
    let tbd: Bool
    let launchLibraryid: String?
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case links = "links"
        case net = "net"
        case window = "window"
        case rocket = "rocket"
        case details = "details"
        case crew = "crew"
        case ships = "ships"
        case capsules = "capsules"
        case payloads = "payloads"
        case launchpad = "launchpad"
        case flightNumber = "flight_number"
        case name = "name"
        case dateutc = "date_utc"
        case dateUnix = "date_unix"
        case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case upcoming = "upcoming"
        case cores = "cores"
        case autoUpdate = "auto_update"
        case tbd = "tbd"
        case launchLibraryid = "launch_library_id"
        case id = "id"
    }
}

// MARK: - Core
struct Core: Codable {
    let core: String?
    let flight: Int?
    let gridfins: Bool?
    let legs: Bool?
    let reused: Bool?
    let landingAttempt: Bool?
    let landingType: String?
    let landpad: String?
    
    enum CodingKeys: String, CodingKey {
        case core = "core"
        case flight = "flight"
        case gridfins = "gridfins"
        case legs = "legs"
        case reused = "reused"
        case landingAttempt = "landing_attempt"
        case landingType = "landing_type"
        case landpad = "landpad"
    }
}

// MARK: - Links
struct Links: Codable {
    let patch: Patch
    let flickr: Flickr
    let wikipedia: String?
    
    enum CodingKeys: String, CodingKey {
        case patch = "patch" 
        case flickr = "flickr"
        case wikipedia = "wikipedia"
    }
}

// MARK: - Flickr
struct Flickr: Codable {
    let small: [String]?
    let original: [String]?
}

// MARK: - Patch
struct Patch: Codable {
    let small: String?
    let large: String?
}

// MARK: - Reddit
//class Reddit:NSManagedObject, Codable {
//    @NSManaged var campaign: String?
//    @NSManaged var recovery: String?
//
//    enum CodingKeys: String, CodingKey {
//        case campaign
//        case recovery
//    }
//
//    required convenience init(from decoder: Decoder) throws {
//        guard
//            let contextUserInfoKey = CodingUserInfoKey.context,
//            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
//            let entity = NSEntityDescription.entity(forEntityName: "Reddit", in: managedObjectContext)
//        else {
//            fatalError("decode failure")
//        }
//        self.init(entity: entity, insertInto: managedObjectContext)
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.campaign = try container.decodeIfPresent(String.self, forKey: .campaign)
//        self.recovery = try container.decodeIfPresent(String.self, forKey: .recovery)
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        do {
//            try container.encode(campaign ?? "", forKey: .campaign)
//            try container.encode(recovery ?? "", forKey: .recovery)
//        } catch {
//            print("error")
//        }
//    }
//}
